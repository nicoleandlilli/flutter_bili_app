import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum StatusStyle{
  lightContent,
  dartContent,
}
class NavigationBar extends StatelessWidget{
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget? child;

  const NavigationBar({
    super.key,
    this.statusStyle=StatusStyle.dartContent,
    this.color=Colors.white,
    this.height=46,
    this.child;
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + height,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: color),
      child: child,
    );
  }

}