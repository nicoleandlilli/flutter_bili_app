import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/home_mo.dart';
import 'package:flutter_bili_app/widget/hi_tab.dart';
import 'package:flutter_bili_app/widget/navigation_bar.dart';
import 'package:flutter_bili_app/widget/video_view.dart';

import '../util/view_util.dart';
import '../widget/appbar.dart';

class VideoDetailPage extends StatefulWidget{
  final VideoMo videoMo;


  const VideoDetailPage({super.key, required this.videoMo});
  // args: {'videoMo':VideoMo(tid:bannerMo.tid)}
  @override
  VideoDetailPageState createState() => VideoDetailPageState();

}

class VideoDetailPageState extends State<VideoDetailPage> with TickerProviderStateMixin{
  late TabController _controller;
  List tabs = ["简介","评论"];

  @override
  void initState() {
    super.initState();
    _statusBarInit();
    _controller=TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(context: context, child: Column(
        children: [
          // iOS黑色状态栏
          // CNavigationBar(
          //   color: Colors.black,
          //   statusStyle: StatusStyle.lightContent,
          //   height: Platform.isAndroid ?0 : 46,
          // )
          VideoView(widget.videoMo.shortLinkV2!,cover:widget.videoMo.pic, overlayUI: videoAppBar(),autoPlay: true,),
          _buildTabNavigation(),
        ],
      )),
    );
  }
  

  void _statusBarInit() async{
    changeStatusBar(color: Colors.black,statusStyle:StatusStyle.lightContent);
  }

  _buildTabNavigation() {
    //带阴影效果
    return Material(
      elevation: 5,
      shadowColor: Colors.grey[100],
      child: Row(
        children: [
          _tabBar(),
          const Padding(padding: EdgeInsets.only(right: 20),child: Icon(Icons.live_tv_rounded,color: Colors.grey,),)
        ],
      ),
    );
  }

  _tabBar() {
    return HiTab(
        tabs.map<Tab>((name) {
          return Tab(
            text: name,
          );
        }).toList(),
        controller: _controller,
    );
  }

}
