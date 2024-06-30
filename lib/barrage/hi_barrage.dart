import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bili_app/barrage/hi_socket.dart';
import 'package:flutter_bili_app/barrage/ibarrage.dart';
import 'package:flutter_bili_app/model/barrage_model.dart';

import '../model/home_mo.dart';
import 'barrage_item.dart';
enum BarrageStatus{
  play,
  pause,
}

///弹幕组件
class HiBarrage extends StatefulWidget {
  final int lineCount;
  final String vid;
  final int speed;
  final double top;
  final bool autoPlay;
  const HiBarrage({super.key,required this.vid, this.lineCount=4,this.speed=800, this.top=0,this.autoPlay=false});

  @override
  HiBarrageState createState() => HiBarrageState();

}

class HiBarrageState extends State<HiBarrage> implements IBarrage{
  late HiSocket _hiSocket;
  late double _height;
  late double _width;
  List<BarrageItem> _barrageItemList = []; //弹幕widget集合
  List<BarrageModel> _barrageModelList = []; //弹幕模型
  int _barrageIndex = 0; //第几条弹幕
  Random _random = Random();
  late BarrageStatus _barrageStatus;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _hiSocket=HiSocket();
    _hiSocket.open(widget.vid).listen((value) {
      _handleMessage(value);
    });
  }

  @override
  void dispose() {
    if(_hiSocket!=null){
      _hiSocket.close();
    }
    if(_timer!=null){
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _width=MediaQuery.of(context).size.width;
    _height=_width/16*9;
    return SizedBox(
      width: _width,
      height: _height,
      child: Stack(
        children: [
          //防止Stack的child为空
          Container(), ..._barrageItemList
          ,
        ],
      ),
    );
  }

  void _handleMessage(List<BarrageModel> modelList,{bool instant = false}) {
    if (kDebugMode) {
      print("received message.................$modelList");
    }
    _hiSocket.send('message from server..............');
    // if(instant){
    //   _barrageModelList.insertAll(0, modelList);
    // }else{
    //   _barrageModelList.addAll(modelList);
    // }

    //收到新的弹幕后播放
    if(_barrageStatus==BarrageStatus.play){
      play();
      return;
    }

    //
    if(widget.autoPlay&&_barrageStatus!=BarrageStatus.pause){
      play();
      return;
    }

  }

  @override
  void play() {
    _barrageStatus=BarrageStatus.play;
    if (kDebugMode) {
      print('action:play');
    }
    if(_timer!=null&&_timer.isActive) return;
    _timer=Timer.periodic(Duration(milliseconds: widget.speed), (timer) {
      if(_barrageModelList.isNotEmpty){
        //将发送的弹幕从集合中剔除
        var temp=_barrageModelList.removeAt(0);
        addBarrage(temp);
        if (kDebugMode) {
          print('start:${temp.content}');
        }
      }else{
        if (kDebugMode) {
          print('All barrage are sent.}');
        }
        //弹幕发送完毕后关闭定时器
        _timer.cancel();
      }
    });


  }

  void addBarrage(BarrageModel temp) {

  }

  @override
  void pause() {
    _barrageStatus = BarrageStatus.pause;
    //清空屏幕上的弹幕
    _barrageModelList.clear();
    setState(() {

    });
    if (kDebugMode) {
      print('action:pause');
    }
    _timer.cancel();
  }

  @override
  void send(String message) {
    if(message==null) return;
    _hiSocket.send(message);
    _handleMessage([
      BarrageModel(content: message, vid: '-1', priority: 1, type: 1),
    ]);
  }

}

