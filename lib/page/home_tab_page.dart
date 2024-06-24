import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bili_app/widget/hi_banner.dart';
import 'package:flutter_bili_app/widget/video_card.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../http/core/hi_error.dart';
import '../http/dao/home_dao.dart';
import '../model/home_mo.dart';
import '../util/toast.dart';

class HomeTabPage extends StatefulWidget{
  String categoryName;
  List<BannerMo>? bannerList ;
  HomeTabPage({super.key,required this.categoryName, this.bannerList});

  @override
  _HomeTabPageState createState() => _HomeTabPageState();

}

class _HomeTabPageState extends State<HomeTabPage>{
  List<VideoMo> videoList = [];
  int pageIndex = 1;


  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemBuilder: (BuildContext context, int index) {
        //有banner时第一个item位置显示banner
        if(widget.bannerList !=null && index ==0){
          return Padding(padding: EdgeInsets.only(bottom: 8),child: _banner(),);
        }else{
          return VideoCard(videoMo: videoList[index]);
        }
      }, staggeredTileBuilder: (int index) {
        if(widget.bannerList!=null&&index==0){
          return const StaggeredTile.fit(2);
        }else{
          return const StaggeredTile.fit(1);
        }
    },);

  }

  _banner() {
    return Padding(
        padding: const EdgeInsets.only(left: 8,right: 8),
      child: HiBanner(widget!.bannerList!),
    );
    
  }
  
  void _loadData({loadMore = false}) async{
    if(!loadMore){
      pageIndex=1;
    }
    var currentIndex = pageIndex + (loadMore? 1: 0);
    try{
      HomeMo result=await HomeDao.get(widget.categoryName,pageIndex: currentIndex, pageSize: 100);
      setState(() {
        if(loadMore){
          if(result?.list!=null){
            videoList=[...videoList,...?result?.list];
            pageIndex++;
          }
        }else{
          videoList = result!.list!;
        }
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
