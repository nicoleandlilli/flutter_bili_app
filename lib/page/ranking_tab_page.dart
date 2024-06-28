import 'package:flutter/material.dart';
import 'package:flutter_bili_app/core/hi_base_tab_state.dart';
import 'package:flutter_bili_app/widget/video_large_card.dart';

import '../http/dao/home_dao.dart';
import '../model/home_mo.dart';
import 'dart:math' as math;

class RankingTabPage extends StatefulWidget {
  final String sort;

  const RankingTabPage({super.key, required this.sort});

  @override
  RankingTabPageState createState() => RankingTabPageState();
}

class RankingTabPageState
    extends HiBaseTabState<HomeMo, VideoMo, RankingTabPage> {
  @override
  get contentChild => Container(
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
    HomeMo result = await HomeDao.get(widget.sort, pageIndex: pageIndex, pageSize: 10);
    return result;
  }


  @override
  List<VideoMo> pareList(HomeMo result) {
    List<VideoMo> lists = result.list!.reversed.toList();
    var index = math.Random().nextInt(9);
    return lists.sublist(index*10,index*10+10)!;
  }

  @override
  bool get wantKeepAlive => true;
}
