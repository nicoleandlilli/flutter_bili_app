import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bili_app/http/dao/login_dao.dart';
import 'package:flutter_bili_app/util/hi_constants.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../model/barrage_model.dart';

///负责与后端进行websocket通信
class HiSocket implements ISocket{
  // static const _URL = 'wss://api.devio.org/uapi/fa/barrage';
  static const _URL = 'ws://echo.websocket.org';
  late IOWebSocketChannel _channel;
  late ValueChanged<List<BarrageModel>> _callBack;

  ///心跳间隔秒数，根据服务器实际timeout时间来调整，这里Nginx服务器的timeout为60
  final int _intervalSeconds = 50;

  @override
  void close() {
    if(_channel != null){
      _channel.sink.close();
    }
  }

  @override
  ISocket listen(ValueChanged<List<BarrageModel>> callBack) {
    _callBack = callBack;
    return this;
  }

  @override
  ISocket open(String vid) {
    _openChannel(vid);
   return this;
  }
  _openChannel(String vid) async{
    // _channel = IOWebSocketChannel.connect(_URL+vid, headers: _headers(), pingInterval: Duration(seconds: _intervalSeconds));
    _channel = IOWebSocketChannel.connect(_URL, headers: _headers(), pingInterval: Duration(seconds: _intervalSeconds));
    _channel.stream.handleError((error){
      if (kDebugMode) {
        print('连接发生错误:$error');
      }
    }).listen((message) {
      _handleMessage(message);

    });
  }

  @override
  ISocket send(String message) {
    _channel.sink.add(message);
    return this;
  }

  _headers(){
    ///设置请求头校验，注意留意：Console的log输出：flutter:received
    Map<String, dynamic> header = {
      HiConstants.authTokenK: HiConstants.authTokenV,
      HiConstants.courseFlagK: HiConstants.courseFlagV,
    };
    header[LoginDao.BOARDING_PASS] = LoginDao.getBoardingPass();
    return header;
  }

  void _handleMessage(message) {
    if (kDebugMode) {
      print('received: $message');
      _channel.sink.add('Hello websocket server!');
      // _channel.sink.add('received!');
      // _channel.sink.close(status.goingAway);
    }
    // var result = BarrageModel.fromJsonString(message);
  }

}

abstract class ISocket{
  ///和服务器建立连接
  ISocket open(String vid);

  ///发送弹幕
  ISocket send(String message);

  ///关闭连接
  void close();

  ///接受弹幕
  ISocket listen(ValueChanged <List<BarrageModel>> callBack);
}