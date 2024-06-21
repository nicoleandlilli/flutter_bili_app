import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_app/main.dart';
import 'package:flutter_bili_app/navigator/hi_navigator.dart';
import 'package:flutter_bili_app/util/color.dart';
import 'package:underline_indicator/underline_indicator.dart';
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
  @override
  void initState() {
    super.initState();
    _controller=TabController(length: tabs.length, vsync: this);
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
  }
  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(listener);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(),
     body: Container(
       child: Column(
         children: [
           Container(
             color: Colors.white,
             padding: EdgeInsets.only(top: 30),
             child: _tabBar(),
           ),
           const Text('首页'),
           MaterialButton(
               onPressed: () {
                 if (kDebugMode) {
                   print("点击了详情按钮");
                 }
                HiNavigator.getInstance().onJumpTo(RouteStatus.detail,
                  args: {'videoMo': VideoModel(10001)});
               },
             child: const Text("详情"),
           ),
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
    tabs: tabs.map<Tab>((tab) {
      return Tab(child: Padding(
        padding: const EdgeInsets.only(left: 5,right: 5),
        child: Text(tab,style: TextStyle(fontSize: 16),),
      ),);
    }).toList(),
    );// tabs: (tabs));
  }
  
}