import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
///登录动效，自定义widget
class LoginEffect extends StatefulWidget{
  final bool protect;

  const LoginEffect({super.key, required this.protect}) ;

  @override
  _LoginEffectState createState() => _LoginEffectState();

}

class _LoginEffectState extends State<LoginEffect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: const Border(bottom: BorderSide(color: Colors.grey),),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _image(true),
        ],
      ),
    );
  }

  _image(bool left){
    var headLeft=widget.protect? 'images/head_left_protect.png':'images/head_left.png';
    var headRight=widget.protect? 'images/head_right_protect.png':'images/head_right.png';
    return Image(
      height: 90,
      image: AssetImage(left?headLeft:headRight),
    );
  }

}