import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_app/util/color.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback? onPressed;

  const LoginButton(this.title, { this.enable = true, this.onPressed});

  @override
  Widget build(BuildContext context) {
    //填充listview的整行
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        height: 45,
        onPressed: enable?onPressed:null,
        disabledColor: primary[50],
        color: primary,
        child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16),),
      ),
    );
  }

}