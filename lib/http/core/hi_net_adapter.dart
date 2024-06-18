import 'dart:convert';

import '../request/base_request.dart';


abstract class HiNetAdapter {
  Future<HiNetResponse<dynamic>> send<T>(BaseRequest request);
}

///统一网络层返回格式
class HiNetResponse<T>{
  HiNetResponse(
    {this.data,
    this.request,
      this.statusCode,
      this.statusMessage,
      this.extra});

  T? data;
  BaseRequest? request;
  int? statusCode;
  String? statusMessage;
  dynamic extra;

  @override
  String toString() {
    if(data is Map){
      return json.encode(data);
    }
    return super.toString();
  }
}