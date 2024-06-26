import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bili_app/core/hi_state.dart';
import 'package:flutter_bili_app/http/core/hi_error.dart';
import 'package:flutter_bili_app/http/dao/home_dao.dart';
import 'package:flutter_bili_app/navigator/hi_navigator.dart';
import 'package:flutter_bili_app/page/home_tab_page.dart';
import 'package:flutter_bili_app/page/video_detail_page.dart';
import 'package:flutter_bili_app/util/color.dart';
import 'package:flutter_bili_app/util/toast.dart';
import 'package:flutter_bili_app/util/view_util.dart';
import 'package:flutter_bili_app/widget/navigation_bar.dart';
import 'package:underline_indicator/underline_indicator.dart';
import '../model/home_mo.dart';


class HomePage extends StatefulWidget {
  final ValueChanged<int>? onJumpTo;
  const HomePage({super.key, this.onJumpTo});
  
  @override
  HomePageState createState() => HomePageState();
  
}
// class _HomePageState extends State<HomePage>

class HomePageState extends HiState<HomePage>
    // with AutomaticKeepAliveClientMixin,TickerProviderStateMixin{
    with AutomaticKeepAliveClientMixin,TickerProviderStateMixin, WidgetsBindingObserver{

  var listener;
  late TabController _controller;
  var tabs = ["推荐","热门", "追播","影视","搞笑","日常","综合","手机游戏","短片-手书-配音"];
  List<CategoryMo> categoryList = [];
  List<BannerMo> bannerList = [];
  late Widget _currentPage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller=TabController(length: categoryList.length, vsync: this);
    HiNavigator.getInstance().addListener(listener = (current, pre) {
      _currentPage = current.page;
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
    WidgetsBinding.instance.removeObserver(this);
    HiNavigator.getInstance().removeListener(listener);
    _controller.dispose();
    super.dispose();
  }

  ///监听应用生命周期变化
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (kDebugMode) {
      print('didChangeAppLifecycleState: $state');
    }
    switch(state){
      case AppLifecycleState.inactive://处于这种状态的应用程序应该假设它们可能在任何时候暂停
        break;
      case AppLifecycleState.resumed: //从后台切换前台，界面可见
      if (kDebugMode) {
        print('home界面又重新可见');
      }
        //fix Android压后台，状态栏字体颜色变白问题
        if(_currentPage is! VideoDetailPage){
          changeStatusBar(color: Colors.black, statusStyle: StatusStyle.lightContent);
        }
        break;
      case AppLifecycleState.paused: //界面不可见，后台
      break;
      case AppLifecycleState.detached://App结束时调用
        break;
      case AppLifecycleState.hidden: //界面不可见时调用
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Column(
       children: [
         CNavigationBar(
           height: 50,
           child: _appBar(),
           color: Colors.white,
           statusStyle: StatusStyle.darkContent,
         ),
         Container(
           color: Colors.white,
           padding: const EdgeInsets.only(top: 30),
           child: _tabBar(),

         ),
         Flexible(child: TabBarView(
           controller: _controller,
           children: categoryList.map((tab) {
             return HomeTabPage(
                 categoryName:tab.title!,
               bannerList: tab.title == '推荐' ? bannerList:null,
               tabIndex: 0,
             );
           }).toList(),
         )),
       ],
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
        child: Text(tab.title!,style: const TextStyle(fontSize: 16),),
      ),);
    }).toList(),
    );// tabs: (tabs));
  }

  _appBar(){
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          InkWell(
            onTap: (){
              if(widget.onJumpTo!=null){
                widget.onJumpTo!(3);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: const Image(
                height: 46,
                width: 46,
                image: AssetImage('images/avatar.png'),
              ),
            ),
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child:  ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    height: 32,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(color: Colors.grey[100]),
                    child: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
          ),
          const Icon(
            Icons.explore_outlined,
            color: Colors.grey,
          ),
          const Padding(padding: EdgeInsets.only(left: 12),
            child: Icon(
              Icons.mail_outline,
              color: Colors.grey,
            ),
          ),

        ],
      ),
    );
  }

  void loadData() async{
    try{
      HomeMo result=await HomeDao.get(tabs[0],pageIndex: 0, pageSize: 100);
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
        BannerMo bm = BannerMo();
        bm.title = tabs[i];
        bm.aid = videoMos?[i+15].aid;
        bm.tid = videoMos?[i+15].tid;
        bm.cover = videoMos?[i+15].pic;
        tempBannerList.add(bm);
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