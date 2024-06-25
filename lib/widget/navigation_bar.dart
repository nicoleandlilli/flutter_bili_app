import 'package:flutter/material.dart';
import 'package:flutter_bili_app/util/view_util.dart';


///可自定义样式的沉浸式导航栏
class CNavigationBar extends StatefulWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget? child;

  const CNavigationBar({
    super.key,
    this.statusStyle=StatusStyle.darkContent,
    this.color=Colors.white,
    this.height=46,
    this.child,
  });

  @override
  CNavigationBarState createState() => CNavigationBarState();

}
class CNavigationBarState extends State<CNavigationBar>{

  @override
  void initState() {
    super.initState();
    _statusBarInit();
  }

  @override
  Widget build(BuildContext context) {
    // _statusBarInit();
    //状态栏高度
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + widget.height,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: widget.color),
      child: widget.child,
    );
  }


void _statusBarInit() async{
  changeStatusBar(color: widget.color,statusStyle:widget.statusStyle);
}


}