import 'package:flutter/foundation.dart';
import 'package:flutter_bili_app/http/core/dio_adapter.dart';
import 'package:flutter_bili_app/http/core/hi_error.dart';

import '../request/base_request.dart';
import 'hi_net_adapter.dart';
import 'mock_adapter.dart';

class HiNet{
  HiNet._();
  static HiNet? _instance;
  static HiNet getInstance(){
    _instance ??= HiNet._();
    return _instance!!;
  }

  Future? fire(BaseRequest request) async {
    HiNetResponse response;
    var error;

    try{
      response = await send(request);
    } on HiNetError catch(e){
      error=e;
      response=e.data;
      printLog(e.message);
    }

    if(response==null){
      printLog(error);
    }

    var result = response.data;
    printLog(result);

    var status=response.statusCode;
    printLog("status.............$status");
    switch(status){
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(),data: result);
      default:
        throw HiNetError(status!, result.toString(),data: result);

    }

    return result;
  }

  // Future? fire(BaseRequest request) async {
  //   var response  = await send(request);
  //
  //   var result = response['data'];
  //   printLog(result);
  //
  //  return result;
  // }

  // Future<dynamic>send<T>(BaseRequest request) async{
  //
  //   printLog('url:${request.url()}');
  //   printLog('method:${request.httpMethod()}');
  //   request.addHeader("token", "123");
  //   printLog('url:${request.url()}');
  //   return Future.value({"statusCode":200,"data":{"code":0,"message":"success"}});
  //
  //   ///使用Mock发送请求
  //   // HiNetAdapter adapter = MockAdapter();
  //   // return adapter.send(request);
  //
  // }


  Future<dynamic>send<T>(BaseRequest request) async{

    printLog('url:${request.url()}');
    printLog('method:${request.httpMethod()}');
    // request.addHeader("token", "123");
    request.addHeader("token", 'ZmEtMjAyMS0wNC0xMiAyMToyMjoyMC1mYQ==fa');
    printLog('url:${request.url()}');

    ///使用Mock发送请求
    // HiNetAdapter adapter = MockAdapter();
    ///使用Mock发送请求
    HiNetAdapter adapter = DioAdapter();
    return adapter.send(request);

  }

  void printLog(log){
    if (kDebugMode) {
      print('hi_net:${log.toString()}');
    }
  }

}
