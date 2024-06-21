import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_app/http/core/hi_error.dart';
import 'package:flutter_bili_app/http/dao/home_dao.dart';
import 'package:flutter_bili_app/main.dart';
import 'package:flutter_bili_app/navigator/hi_navigator.dart';
import 'package:flutter_bili_app/page/home_tab_page.dart';
import 'package:flutter_bili_app/util/color.dart';
import 'package:flutter_bili_app/util/toast.dart';
import 'package:underline_indicator/underline_indicator.dart';
import '../model/home_mo.dart';
import '../model/video_model.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  _HomePageState createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin,TickerProviderStateMixin{
  var listener;
  late TabController _controller;
  var tabs = ["推荐","热门", "追播","影视","搞笑","日常","综合","手机游戏","短片-手书-配音"];
  List<CategoryMo> categoryList = [];
  List<BannerMo> bannerList = [];

  @override
  void initState() {
    super.initState();
    _controller=TabController(length: categoryList.length, vsync: this);
    HiNavigator.getInstance().addListener(listener = (current, pre) {
      if (kDebugMode) {
        print('home:current:${current.page}');
      }
      if (kDebugMode) {
        print('home:pre:${pre.page}');
      }

      if(widget==current.page||current.page is HomePage){
        if (kDebugMode) {
          print('打开了首页：onResume');
        }
      }else if(widget == pre?.page || pre?.page is HomePage){
        if (kDebugMode) {
          print('首页：onPause');
        }
      }
    });
    loadData();
  }
  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(listener);
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Container(
       child: Column(
         children: [
           Container(
             color: Colors.white,
             padding: const EdgeInsets.only(top: 30),
             child: _tabBar(),
           ),
           Flexible(child: TabBarView(
             controller: _controller,
             children: categoryList.map((tab) {
               print('init Flexible..........${categoryList.length}');
               return HomeTabPage(
                   name:tab.title!,
                 bannerList: tab.title == '推荐' ? bannerList:null,
               );
             }).toList(),
           )),
         ],
       ),
     ),
   );
  }

  @override
  bool get wantKeepAlive => true;

  _tabBar() {
    return TabBar(
      controller: _controller,
        isScrollable: true,
        labelColor: Colors.black,
        indicator: const UnderlineIndicator(
            strokeCap: StrokeCap.round,
            borderSide: BorderSide(color: primary,width: 3),
            insets: EdgeInsets.only(left: 15,right: 15),
        ),
    tabs: categoryList.map<Tab>((tab) {
      return Tab(child: Padding(
        padding: const EdgeInsets.only(left: 5,right: 5),
        child: Text(tab.title!,style: TextStyle(fontSize: 16),),
      ),);
    }).toList(),
    );// tabs: (tabs));
  }

  void loadData() async{
    try{
      HomeMo result=await HomeDao.getRecommandVideos();
      if (kDebugMode) {
        print("Home页获取到数据：$result");
      }
      List<VideoMo>? videoMos = result?.list;

      if(videoMos!=null){
        //tab长度变化后需要重新创建TabController
        //此处为模拟数据
        _controller=TabController(length: tabs!.length, vsync: this);
      }

      List<CategoryMo> tempCategoryList = [];
      for(int i=0;i<tabs!.length;i++) {
        tempCategoryList.add(CategoryMo(title: tabs[i]));
      }
      //模拟数据
      List<BannerMo> tempBannerList = [];
      for(int i=0;i<4;i++){
        tempBannerList.add(BannerMo(title: tabs[i]));
      }


      setState(() {
        categoryList = tempCategoryList;
        bannerList = tempBannerList;
      });
    }on NeedAuth catch(e){
      if (kDebugMode) {
        print(e);
      }
      showWarnToast(e.message);
    }on HiNetError catch(e){
      if (kDebugMode) {
        print(e);
      }
      showWarnToast(e.message);
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
      showWarnToast(e.toString());
    }
  }
  
}