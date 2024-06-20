import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_app/util/toast.dart';
import 'package:flutter_bili_app/widget/appbar.dart';
import 'package:flutter_bili_app/widget/login_effect.dart';

import '../db/hi_cache.dart';
import '../http/core/hi_error.dart';
import '../http/dao/login_dao.dart';
import '../util/string_util.dart';
import '../widget/login_button.dart';
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
            LoginInput(
              "确认密码",
              "请再次输入密码",
              true,
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
            child:  LoginButton("注册", enable: loginEnable, onPressed: checkParams,),),
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
    // _Map<String, dynamic>
    try {
      var result = await LoginDao.registration(
          userName!, password!, imoocId!, orderId!);

      if(result['code'] == 0){
        print('注册成功');
      showToast("注册成功");
        if(widget.onJumpToLogin != null){
          widget.onJumpToLogin();
        }
      }else{
        print(result['msg']);
        // showWarnToast(result['msg']);

         HiCache.getInstance()?.setString("key", "value");
         HiCache.getInstance()?.setString("username", "$userName");
         HiCache.getInstance()?.setString("password", "$password");
        showToast("注册成功");
         // widget.onSuccess();
      }

      // if(result != null){
      //   if (kDebugMode) {
      //     print('注册成功');
      //   }
      //   showToast("注册成功")
      //   if(widget.onJumpToLogin != null){
      //     widget.onJumpToLogin();
      //   }
      // }

      if (kDebugMode) {
        print(result);
      }
    }on NeedAuth catch(e){
      if (kDebugMode) {
        print(e);
      }
      showWarnToast(e.message);
    }on HiNetError catch(e){
      if (kDebugMode) {
        print(e);
      }
      showWarnToast(e.message);
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
      showWarnToast(tips!);
      return;
    }
    send();
  }

}

