import 'package:flutter/cupertino.dart';
///弹幕widget
class BarrageItem extends StatelessWidget {
  final String? id;
  final double? top;
  final Widget? child;
  final ValueChanged? onComplete;
  final Duration duration;

  const BarrageItem(
      {super.key,
      this.id,
      this.top,
      this.onComplete,
      this.duration = const Duration(minutes: 9000),
      this.child}
      );

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }


}