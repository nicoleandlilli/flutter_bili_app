import 'package:flutter/material.dart';

enum StatusStyle{
  lightContent,
  dartContent,
}
class CNavigationBar extends StatelessWidget{
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget? child;

  const CNavigationBar({
    super.key,
    this.statusStyle=StatusStyle.dartContent,
    this.color=Colors.white,
    this.height=46,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    _statusBarInit();
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + height,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: color),
      child: child,
    );
  }

  void _statusBarInit() {
    //沉浸式状态栏样式
    // FlutterS

  }

}