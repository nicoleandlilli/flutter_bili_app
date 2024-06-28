import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_app/util/view_util.dart';
import 'package:flutter_bili_app/widget/hi_blur.dart';
import 'package:flutter_bili_app/widget/hi_flexible_header.dart';

import '../http/core/hi_error.dart';
import '../http/dao/home_dao.dart';
import '../model/home_mo.dart';
import '../util/toast.dart';
import 'dart:math' as math;

class ProfilePage extends StatefulWidget{
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();

}


class ProfilePageState extends State<ProfilePage> {
  VideoMo? _profileMo;
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
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxISsCROLLED){
          return <Widget>[
            _buildAppBar(),
          ];
        }, body: ListView.builder(
          itemBuilder: (BuildContext context, int index){
            return ListTile(
             title: Text('标题$index'),
            );
          },
          itemCount: 20,
        ),
      ),
    );
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
      // List<VideoMo>? videoMos = result?.list;
      setState(() {
        var index = math.Random().nextInt(100);
        _profileMo = result.list![index];
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

}