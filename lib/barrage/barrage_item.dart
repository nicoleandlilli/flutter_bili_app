import 'package:flutter/cupertino.dart';
///弹幕widget
class BarrageItem extends StatelessWidget {
  final String? id;
  final double top;
  final Widget? child;
  final ValueChanged? onComplete;
  final Duration duration;

  const BarrageItem(
      {super.key,
      this.id,
      required this.top,
      this.onComplete,
      this.duration = const Duration(minutes: 9000),
      this.child}
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: top),
      child: child,
    );
  }


}