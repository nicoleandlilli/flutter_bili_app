import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/home_mo.dart';

///可展开的widget
class ExpandableContent extends StatefulWidget {
  final VideoMo videoMo;

  const ExpandableContent({super.key, required this.videoMo});

  @override
  ExpandableContentState createState() => ExpandableContentState();

}


class  ExpandableContentState extends State<ExpandableContent> with SingleTickerProviderStateMixin{
  static final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);
  bool _expand = false;
  //用来管理Animation
  late AnimationController _controller;
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller=AnimationController(duration: const Duration(milliseconds: 200),vsync: this);
    _heightFactor=_controller.drive(_easeInTween);
    _controller.addListener(() {
      //监听动画值的变化
      if (kDebugMode) {
        print(_heightFactor.value);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
      child: Column(
        children: [
          _buildTitle(),
          const Padding(padding: EdgeInsets.only(bottom: 8)),
        ],
      ),
    );
  }

  _buildTitle() {
    return InkWell(
      onDoubleTap: _toggleExpand,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //通过Expanded让Text获得最大宽度,以便显示省略号
          Expanded(
            child: Text(widget.videoMo.title!, maxLines: 1, overflow: TextOverflow.ellipsis,),
          ),
          const Padding(padding: EdgeInsets.only(left: 15)),
          Icon(_expand?Icons.keyboard_arrow_up_sharp:Icons.keyboard_arrow_down_sharp),
        ],
      ),
    );
  }


  void _toggleExpand() {
  }
}