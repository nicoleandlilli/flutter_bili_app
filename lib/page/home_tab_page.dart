import 'package:flutter/cupertino.dart';

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
    return Container(
      alignment: Alignment.center,
      child: Text(widget.name),
    );
  }

}
