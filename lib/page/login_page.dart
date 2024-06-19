import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_app/util/toast.dart';
import 'package:flutter_bili_app/widget/appbar.dart';
import 'package:flutter_bili_app/widget/login_button.dart';
import 'package:flutter_bili_app/widget/login_effect.dart';

import '../http/core/hi_error.dart';
import '../http/dao/login_dao.dart';
import '../util/string_util.dart';
import '../widget/login_input.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();


}

class _LoginPageState extends State<LoginPage> {
  bool protect = false;
  bool loginEnable = false;
  String? userName;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("密码登录", "注册", () {

    }),
    body: Container(
    child: ListView(
      children: [
        LoginEffect(protect: protect),
        LoginInput(
          "用户名",
          "请输入用户名",
          false,
          true,
          onChanged: (text) {
            userName=text;
            checkInput();
          },
        ),
        LoginInput(
          "密码",
          "请输入密码",
          true,
          true,
          onChanged: (text) {
            password=text;
            checkInput();
          },
          focusChanged: (focus) {
            setState(() {
              protect = focus;
            });
          },
        ),
        Padding(padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: LoginButton("登录", enable: loginEnable, onPressed: send,),),
    ],
    ),
    ),
    );
  }

  void checkInput() {
    bool enable;
    if(isNotEmpty(userName!) &&
        isNotEmpty(password)){
      enable = true;
    }else{
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  void send() async{
    try {
      var result = await LoginDao.login( userName!, password!);

      if(result['code'] == 0){
        print('登录成功');

      }else{
      print(result['msg']);
      showWarnToast(result['msg']);
      }

      if(result != null){
        if (kDebugMode) {
          print('登录成功');
          showToast("登录成功");

        }
      }

      if (kDebugMode) {
        print(result);
      }
    }on NeedAuth catch(e){
      showWarnToast(e.message);
      if (kDebugMode) {
        print(e);
      }
    }on HiNetError catch(e){
      showWarnToast(e.message);
      if (kDebugMode) {
        print(e);
      }
    }
  }


}