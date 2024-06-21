import 'package:flutter_bili_app/http/request/base_request.dart';

abstract class CustomBaseRequest extends BaseRequest{
  @override
  String authority(){
    return "api.bilibili.com";
  }

}