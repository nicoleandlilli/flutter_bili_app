import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/home_mo.dart';
import 'package:flutter_bili_app/page/ranking_tab_page.dart';

import '../core/hi_base_tab_state.dart';
import '../http/dao/home_dao.dart';
import 'dart:math' as math;

import '../widget/video_large_card.dart';

class FavoritePage extends StatefulWidget{
  const FavoritePage({super.key});

  @override
  FavoritePageState createState() => FavoritePageState();

}


class FavoritePageState extends HiBaseTabState<HomeMo, VideoMo, FavoritePage> {
  List<VideoMo> categoryList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  get contentChild => Container(
    margin: const EdgeInsets.only(top: 45),
    child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 10),
        itemCount: dataList.length,
        controller: scrollController,
        itemBuilder: (BuildContext context, int index) =>
            VideoLargeCard(videoModel: dataList[index])),
  );

  @override
  Future<HomeMo> getData(int pageIndex) async{
    HomeMo result = await HomeDao.get('收藏', pageIndex: pageIndex, pageSize: 10);
    return result;
  }

  @override
  List<VideoMo> pareList(HomeMo result) {
    List<VideoMo> lists = result.list!.reversed.toList();
    var index = math.Random().nextInt(9);
    return lists.sublist(index*10,index*10+10)!;
  }

}