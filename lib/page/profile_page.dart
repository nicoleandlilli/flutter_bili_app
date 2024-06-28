import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_app/util/view_util.dart';
import 'package:flutter_bili_app/widget/course_card.dart';
import 'package:flutter_bili_app/widget/hi_blur.dart';
import 'package:flutter_bili_app/widget/hi_flexible_header.dart';

import '../http/core/hi_error.dart';
import '../http/dao/home_dao.dart';
import '../model/home_mo.dart';
import '../util/toast.dart';
import 'dart:math' as math;

import '../widget/hi_banner.dart';

class ProfilePage extends StatefulWidget{
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();

}


class ProfilePageState extends State<ProfilePage> with AutomaticKeepAliveClientMixin{
  VideoMo? _profileMo;
  List<BannerMo> bannerList = [];
  List<VideoMo> dataList = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_profileMo==null){
      return Container();
    }else{
      return Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxISsCROLLED){
            return <Widget>[
              _buildAppBar(),
            ];
          },
          body: ListView(
            padding: const EdgeInsets.only(top: 10),
            children: [
              ..._buildContentList(),
            ],
          ),
        ),
      );
    }

  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
            expandedHeight: 160,//扩展高度
            pinned: true,//高度是否固定
            flexibleSpace: FlexibleSpaceBar(//定义固定空间
              collapseMode: CollapseMode.parallax,
              titlePadding: const EdgeInsets.only(left: 10),
              title: _buildHead(),
              background: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                      child: cachedImage(_profileMo!.firstFrame!),
                  ),
                  const Positioned.fill(
                    child: HiBlur(sigma: 20,),
                  ),
                  Positioned(bottom: 0, left: 0, right: 0, child: _buildProfileTab())
                ],
              ),
            ),
          );
  }

  void loadData() async{
    try{
      HomeMo result=await HomeDao.get('个人中心',pageIndex: 0, pageSize: 100);
      if (kDebugMode) {
        print("Home页获取到数据：$result");
      }
      List<VideoMo>? videoMos = result?.list;
      //模拟数据
      List<BannerMo> tempBannerList = [];
      for(int i=0;i<4;i++){
        BannerMo bm = BannerMo();
        VideoMo videoMo = videoMos![i+45]!;
        bm.title = videoMo.title;
        bm.aid = videoMo.aid;
        bm.tid = videoMo.tid;
        bm.cover =videoMo.pic;
        tempBannerList.add(bm);
      }
      setState(() {
        var index = math.Random().nextInt(100);
        _profileMo = result.list![index];
        bannerList = tempBannerList;
        dataList = videoMos!.sublist(0,3);
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

  _buildHead() {
    if(_profileMo==null) return Container();
    return HiFlexibleHeader(name: _profileMo!.owner!.name!, face: _profileMo!.firstFrame!, controller: _scrollController);
  }

  @override
  bool get wantKeepAlive => true;

  _buildProfileTab() {
    if (_profileMo == null) return Container();
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      decoration: const BoxDecoration(color: Colors.white54),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText('收藏', _profileMo!.stat!.favorite!%100),
          _buildIconText('点赞', _profileMo!.stat!.like!%100),
          _buildIconText('浏览', _profileMo!.stat!.view!%100),
          _buildIconText('金币', _profileMo!.stat!.coin!%100),
          _buildIconText('粉丝', _profileMo!.stat!.hisRank!),
        ],
      ),
    );
  }

  _buildIconText(String text, int count) {
    return Column(
      children: [
        Text('$count', style: TextStyle(fontSize: 15, color: Colors.black87)),
        Text(text, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  _buildContentList() {
    if (_profileMo == null) {
      return [];
    }
    return [
      _buildBanner(),
      CourseCard(courseList: dataList,)
    ];
  }

   _buildBanner() {
    return HiBanner(bannerList,
        bannerHeight: 120, padding: const EdgeInsets.only(left: 10, right: 10));
  }

}