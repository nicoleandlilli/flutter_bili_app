import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/home_mo.dart';
import 'package:flutter_bili_app/navigator/hi_navigator.dart';
import 'package:flutter_bili_app/widget/hi_banner.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class HiBanner extends StatelessWidget {
  final List<BannerMo> bannerList;
  final double bannerHeight;
  final EdgeInsetsGeometry? pading;

  const HiBanner(this.bannerList,{super.key,  this.pading, this.bannerHeight=160,});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bannerHeight,
      child: _banner(),
    );
  }

  _banner() {
    var right=10+(pading?.horizontal??0)/2;
    return Swiper(
      autoplay: true,
      itemBuilder: (BuildContext context, int index){
        return _image(bannerList[index]);
      },
      //自定义指示器
      pagination: SwiperPagination(
        alignment: Alignment.bottomRight,
        margin: EdgeInsets.only(right: right, bottom: 10),
        builder: const DotSwiperPaginationBuilder(
          color: Colors.white60,
          size: 6,
          activeSize: 6,
        ),
      ),
       itemCount: bannerList!.length,
    );
    
  }

  _image(BannerMo bannerMo) {
    return InkWell(
      onTap: (){
        if (kDebugMode) {
          print(bannerMo.title);
        }
        _handleClick(bannerMo);
      },
      child: Container(
        padding: pading,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          // child: Image.network(bannerMo.cover, fit: BoxFit.cover,),
          child: Image.network(
            bannerMo!.cover!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _handleClick(BannerMo bannerMo) {
    // if(bannerMo.type=='video'){
    //   HiNavigator.getInstance().onJumpTo(RouteStatus.detail, args: {'videoMo':VideoMo(tid:bannerMo.tid)});
    // }else{
    //   print(bannerMo.tid);
    // }

    HiNavigator.getInstance().onJumpTo(RouteStatus.detail, args: {'videoMo':VideoMo(tid:bannerMo.tid)});
  }

}