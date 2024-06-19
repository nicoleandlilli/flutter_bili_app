import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_app/widget/appbar.dart';
import 'package:flutter_bili_app/widget/login_effect.dart';

import '../http/core/hi_error.dart';
import '../http/dao/login_dao.dart';
import '../util/string_util.dart';
import '../widget/login_input.dart';

class RegistrationPage extends StatefulWidget{
  final VoidCallback onJumpToLogin;

  const RegistrationPage({super.key, required this.onJumpToLogin});

    @override
   _RegistrationPageState createState() => _RegistrationPageState();

  }

class _RegistrationPageState extends State<RegistrationPage>{
  bool protect = false;
  bool loginEnable = false;
  String? userName;
  String? password;
  String? rePassword;
  String? imoocId;
  String? orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", widget.onJumpToLogin),
      body: Container(
        child: ListView(
          //自适应键盘弹起，防止遮挡
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
              false,
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
            LoginInput(
              "确认密码",
              "请再次输入密码",
              false,
              true,
              onChanged: (text) {
                rePassword=text;
                checkInput();
              },
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
            ),
            LoginInput(
              "慕课网ID",
              "请输入你的慕课网用户ID",
              false,
              true,
              keyboardType: TextInputType.number,
              onChanged: (text) {
                imoocId=text;
                checkInput();
              },
            ),
            LoginInput(
              "课程订单号",
              "请输入课程订单号后四位",
              false,
              true,
              keyboardType: TextInputType.number,
              onChanged: (text) {
                orderId=text;
                checkInput();
              },
            ),
            Padding(padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: _loginButton(),),
          ]

        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if(isNotEmpty(userName!) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword) &&
        isNotEmpty(imoocId) &&
        isNotEmpty(orderId)){
      enable = true;
    }else{
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  _loginButton() {
    return InkWell(
      onTap: (){
        if(loginEnable){
          // send();
          checkParams();
        }else{
          if (kDebugMode) {
            print('loginEnable is false');
          }
        }
      },
      child: const Text('注册'),
    );
  }

  void send() async{
    try {
      var result = await LoginDao.registration(
          userName!, password!, imoocId!, orderId!);

      // if(result['0'] == 0){
      //   print('注册成功');
      //   if(widget.onJumpToLogin != null){
      //     widget.onJumpToLogin();
      //   }
      // }else{
      // print(result['msg']);
      // }

      if(result != null){
        if (kDebugMode) {
          print('注册成功');
        }
        if(widget.onJumpToLogin != null){
          widget.onJumpToLogin();
        }
      }

      if (kDebugMode) {
        print(result);
      }
    }on NeedAuth catch(e){
      if (kDebugMode) {
        print(e);
      }
    }on HiNetError catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void checkParams() {
    String? tips;
    if(password != rePassword){
      tips = '两次密码不一致';
    }else if(orderId?.length != 4){
      tips = '请输入订单号的后四位';
    }
    if(tips != null){
      print(tips);
      return;
    }
    send();
  }

}

