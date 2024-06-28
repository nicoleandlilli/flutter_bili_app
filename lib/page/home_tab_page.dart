import 'package:flutter/cupertino.dart';
import 'package:flutter_bili_app/core/hi_base_tab_state.dart';
import 'package:flutter_bili_app/widget/hi_banner.dart';
import 'package:flutter_bili_app/widget/video_card.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../http/dao/home_dao.dart';
import '../model/home_mo.dart';
import 'dart:math' as math;

class HomeTabPage extends StatefulWidget{
  String categoryName;
  int tabIndex;
  List<BannerMo>? bannerList ;
  var tabs = ["推荐","热门", "追播","影视","搞笑","日常","综合","手机游戏","短片-手书-配音"];
  HomeTabPage({super.key,required this.categoryName, this.bannerList,required this.tabIndex});

  @override
  HomeTabPageState createState() => HomeTabPageState();

}

// class HomeTabPageState extends State<HomeTabPage> {
class HomeTabPageState extends HiBaseTabState<HomeMo, VideoMo,HomeTabPage>{

  @override
  void initState() {
    super.initState();
    print(widget.categoryName);
    print(widget.bannerList);
  }

  @override
  // Widget build(BuildContext context) {
  //   return MediaQuery.removePadding(
  //       context: context,
  //       removeTop: true,
  //       child: StaggeredGridView.countBuilder(
  //         crossAxisCount: 2,
  //         itemCount: dataList.length,
  //         padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
  //         itemBuilder: (BuildContext context, int index) {
  //           //有banner时第一个item位置显示banner
  //           if (widget.bannerList != null && index == 0) {
  //             return Padding(
  //               padding: const EdgeInsets.only(bottom: 8), child: _banner(),);
  //           } else {
  //             return VideoCard(videoMo: dataList[index]);
  //           }
  //         }, staggeredTileBuilder: (int index) {
  //         if (widget.bannerList != null && index == 0) {
  //           return const StaggeredTile.fit(2);
  //         } else {
  //           return const StaggeredTile.fit(1);
  //         }
  //       },));
  //
  // }

  _banner() {
    return HiBanner(widget.bannerList!, pading: const EdgeInsets.only(left: 5, right: 5),);
    // return Padding(
    //     padding: const EdgeInsets.only(left: 5,right: 5),
    //   child: HiBanner(widget!.bannerList!),
    // );
    
  }

  @override
  get contentChild => StaggeredGridView.countBuilder(
    crossAxisCount: 2,
    itemCount: dataList.length,
    controller: scrollController,
    padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
    itemBuilder: (BuildContext context, int index) {
      //有banner时第一个item位置显示banner
      if (widget.bannerList != null && index == 0) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8), child: _banner(),);
      } else {
        return VideoCard(videoMo: dataList[index]);
      }
    }, staggeredTileBuilder: (int index) {
    if (widget.bannerList != null && index == 0) {
      return const StaggeredTile.fit(2);
    } else {
      return const StaggeredTile.fit(1);
    }
  },);



  @override
  Future<HomeMo> getData(int pageIndex) async{
    HomeMo result = await HomeDao.get(widget.categoryName, pageIndex: pageIndex, pageSize: 10);
    return result;
  }

  @override
  List<VideoMo> pareList(HomeMo result) {
    List<VideoMo> lists = result.list!;
    var index = math.Random().nextInt(9);
    return lists.sublist(index*10,index*10+10)!;
  }

}
