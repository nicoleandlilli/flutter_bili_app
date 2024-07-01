import 'package:flutter/cupertino.dart';
import 'package:flutter_bili_app/barrage/barrage_transition.dart';
///弹幕widget
class BarrageItem extends StatelessWidget {
  final String? id;
  final double top;
  final Widget child;
  final ValueChanged onComplete;
  final Duration duration;

  BarrageItem(
      {super.key,
      this.id,
      required this.top,
      required this.onComplete,
      this.duration = const Duration(milliseconds: 9000),
      required this.child}
      );

  final _key=GlobalKey<BarrageTransitionState>();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: top,
      child: BarrageTransition(
        key:_key,
        onComplete:(v){
          onComplete(id);
        },
        duration: duration,
        child: child,
      ),
    );
  }


}