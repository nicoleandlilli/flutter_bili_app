import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_app/util/color.dart';

///登录输入框，自定义Widget
class LoginInput extends StatefulWidget{
  final String title;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? focusChanged;
  final bool lineStretch;
  final bool obscureText;
  final TextInputType? keyboardType;

  const LoginInput(
      this.title,
      this.hint,
      this.obscureText,
      this.lineStretch,
      {super.key,
      this.onChanged,
      this.focusChanged,
      this.keyboardType});

  @override
  _LoginInputState createState() => _LoginInputState();

}

class _LoginInputState extends State<LoginInput>{
  final _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    //是否获取光标的监听
    _focusNode.addListener(() {
      print("Has foucus:${_focusNode.hasFocus}");
      if(widget.focusChanged != null){
        widget.focusChanged!(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              width: 100,
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            _input()
          ],
        ),
        Padding(padding: EdgeInsets.only(left: !widget.lineStretch? 15:0),
        child: const Divider(
          height: 1,
          thickness: 0.5,
        ),)
      ],
    );
  }

  _input() {
    return Expanded(child: TextField(
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      autofocus: !widget.obscureText,
      cursorColor: primary,
      style: const TextStyle(fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w300),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20, right: 20),
        border: InputBorder.none,
        hintText: widget.hint??'',
        hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
      ),
    ));
  }
}

