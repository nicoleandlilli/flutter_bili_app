import 'package:dio/dio.dart';
import 'package:flutter_bili_app/http/core/hi_error.dart';
import 'package:flutter_bili_app/http/core/hi_net_adapter.dart';
import 'package:flutter_bili_app/http/request/base_request.dart';

///Dio适配器
class DioAdapter extends HiNetAdapter{
  @override
  Future<HiNetResponse<dynamic>> send<T>(BaseRequest request) async{
    var response;
    var options = Options(headers: request.header);
    var error;
    try{
      if(request.httpMethod()==HttpMethod.GET){
        response= await Dio().get(request.url(),options: options);
      }else if(request.httpMethod()==HttpMethod.POST){
        response= await Dio().post(request.url(),data: request.params,options: options);
      }else if(request.httpMethod()==HttpMethod.DELETE){
        response= await Dio().delete(request.url(),data: request.params,options: options);
      }
      print('dio_adapter..........:finish request, get response');
    }on DioError catch(e){
      error=e;
      response=e.response;
      print('dio_adapter..........:${e.toString()}.......${e.response}');
    }
    if(error!=null){
      //抛出HiNetError
      print('dio_adapter..........:error.......${error.toString()}..........${error.response}');
      throw HiNetError(response?.statusCode ?? -1, error.toString(),data: buildRes(response,request));
    }
    return buildRes(response, request);
  }

  ///构建HiNetResponse
  HiNetResponse buildRes(response, BaseRequest request) {
    return HiNetResponse(
      data: response.data,
      request: request,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response
    );
  }

}