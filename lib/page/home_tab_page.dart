import 'package:flutter/cupertino.dart';
import 'package:flutter_bili_app/widget/hi_banner.dart';

import '../model/home_mo.dart';

class HomeTabPage extends StatefulWidget{
  String name;
  List<BannerMo>? bannerList ;
  HomeTabPage({super.key,required this.name, this.bannerList});

  @override
  _HomeTabPageState createState() => _HomeTabPageState();

}

class _HomeTabPageState extends State<HomeTabPage>{
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: [
            if(widget.bannerList!=null)_banner(),
          ],
        )
    );
    // return Container(
    //   child: ListView(
    //     //dart collection if灵活创建列表
    //     children: [
    //       if(widget.bannerList!=null)_banner()
    //     ],
    //   ),
    // );
  }

  _banner() {
    return Padding(
        padding: EdgeInsets.only(left: 8,right: 8),
      child: HiBanner(widget!.bannerList!),
    );
    
  }

}
