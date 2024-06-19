import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/login_input.dart';

class RegistrationPage extends StatefulWidget{
  const RegistrationPage({super.key});


    @override
   _RegistrationPageState createState() => _RegistrationPageState();

  }

class _RegistrationPageState extends State<RegistrationPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          //自适应键盘弹起，防止遮挡
          children: [
            LoginInput(
              "用户名",
              "请输入用户名",
              false,
              true,
              onChanged: (text) {
                print(text);
              },
            ),
            LoginInput(
              "密码",
              "请输入密码",
              false,
              true,
              onChanged: (text) {
                print(text);
              },
            ),
          ]

        ),
      ),
    );
  }

}