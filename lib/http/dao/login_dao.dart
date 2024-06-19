import 'package:flutter/foundation.dart';
import 'package:flutter_bili_app/http/core/hi_net.dart';
import 'package:flutter_bili_app/http/request/base_request.dart';
import 'package:flutter_bili_app/http/request/login_request.dart';
import 'package:flutter_bili_app/http/request/registration_request.dart';

class LoginDao{
  static login(String userName, String password){
    return _send(userName, password);
  }

  static registration(String userName, String password, String imoocId, String orderId){
    return _send(userName, password, imoocId: imoocId, orderId: orderId);
  }

  static _send(String userName, String password,{imoocId,orderId}) async{
    BaseRequest request;
    if(imoocId != null && orderId != null){
      request = RegistrationRequest();
      request
          .addParam("userName", userName)
          .addParam("password", password)
          .addParam("imoocId", imoocId)
          .addParam("orderId", orderId);
    }else{
      request = LoginRequest();
      request
          .addParam("userName", userName)
          .addParam("password", password);
    }


    var result = await HiNet.getInstance().fire(request);
    if (kDebugMode) {
      print(result);
    }
  }
}