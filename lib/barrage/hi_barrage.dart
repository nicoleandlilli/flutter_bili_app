import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bili_app/barrage/barrage_view_util.dart';
import 'package:flutter_bili_app/barrage/hi_socket.dart';
import 'package:flutter_bili_app/barrage/ibarrage.dart';
import 'package:flutter_bili_app/model/barrage_model.dart';
import 'barrage_item.dart';
import 'dart:math' as math;

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
  final List<BarrageItem> _barrageItemList = []; //弹幕widget集合
  final List<BarrageModel> _barrageModelList = []; //弹幕模型
  int _barrageIndex = 0; //第几条弹幕
  final Random _random = Random();
  late BarrageStatus _barrageStatus;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _hiSocket=HiSocket();
    _hiSocket.open(widget.vid).listen((value) {
      _handleMessage(value);
    });
    getPreBarrages();
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
          Container(),
          ..._barrageItemList
          ,
        ],
      ),
    );
  }

  void _handleMessage(List<BarrageModel> modelList,{bool instant = false}) {
    if (kDebugMode) {
      print("received message.................$modelList");
    }
    // _hiSocket.send('message from server..............');
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

  // late String content;
  // late String vid;
  // late int priority;
  // late int type;
  void getPreBarrages(){
    List<BarrageModel> barrageMOs=[
      BarrageModel(content: '我班有个同学叫章正伟……', vid: 'df38309b', priority: 1, type: 1,),
      BarrageModel(content: '特朗普:“外星人的入侵都是因为中国，需要向我们赔偿', vid: '248a665c', priority: 1, type: 1,),
      BarrageModel(content: '吴岳是真的惨，刚当上舰长，船就要拆了。。', vid: 'b06bc17', priority: 1, type: 1,),
      BarrageModel(content: '华强！诶，华强！', vid: 'b888d1b6', priority: 1, type: 1,),
      BarrageModel(content: '麦块的缺点是方块，会穿模；麦块的优点在方块，这是他的灵魂', vid: 'b0da8d6b', priority: 1, type: 1,),
      BarrageModel(content: '与此同时，在他们上方一万米的天上的飞机里，有个叫罗辑的人', vid: '7295db1f', priority: 1, type: 1,),
      BarrageModel(content: '一只罗辑飞过', vid: 'ac7fe70b', priority: 1, type: 1,),
      BarrageModel(content: '一个野生面壁者的诞生', vid: 'eca9f0ee', priority: 1, type: 1,),
      BarrageModel(content: '叶文洁：啊对对对，我的思想最纯洁了', vid: '421b61dc', priority: 1, type: 1,),
      BarrageModel(content: '《好》', vid: '1a2324e3', priority: 1, type: 1,),
      BarrageModel(content: '苏 修 美 帝', vid: 'a65be0fc', priority: 1, type: 1,),
      BarrageModel(content: '智子：讲的非常好，继续继续', vid: 'cb27f685', priority: 1, type: 1,),
      BarrageModel(content: '致敬每个中国军人', vid: 'be76958e', priority: 1, type: 1,),
      BarrageModel(content: '这个搪瓷茶缸更精致了', vid: 'd450e89d', priority: 1, type: 1,),
      BarrageModel(content: '不要被外表所欺骗，这是一部神级动画', vid: '382b746d', priority: 1, type: 1,),
      BarrageModel(content: '三体人：真以为我不看B战', vid: '1108958b', priority: 1, type: 1,),
      BarrageModel(content: '海的对面是蓝精灵（doge）', vid: '7c643dec', priority: 1, type: 1,),
      BarrageModel(content: '艾伦：不我不想', vid: '25d6d3d6', priority: 1, type: 1,),
      BarrageModel(content: '宇宙战舰大和号', vid: '9b216f62', priority: 1, type: 1,),
      BarrageModel(content: '热知识：二炮是火箭军', vid: '57a1b06d', priority: 1, type: 1,),
      BarrageModel(content: '外星人说英语，二维生物说日语', vid: 'dd8d68c1', priority: 1, type: 1,),
      BarrageModel(content: '常伟思，章北海的“破壁人”，唯一一个看出章北海是“失败主义”的人', vid: '99b9c4b2', priority: 1, type: 1,),
      BarrageModel(content: '刘慈欣的《流浪地球》一书中写有一个维护宇宙和平的外星文明，和三体冲突', vid: '43d6012d', priority: 1, type: 1,),
      BarrageModel(content: '恭喜你发现了保障', vid: '7395fa29', priority: 1, type: 1,),
      BarrageModel(content: '注：这时候罗辑还在去美国的飞机上', vid: '428d6b3a', priority: 1, type: 1,),
      BarrageModel(content: '如果把海那边的敌人都杀光，我们是不是就真的自由了呢...', vid: 'a5203b0c', priority: 1, type: 1,),
    ];

    var index1 = math.Random().nextInt(26);
    var index2 = math.Random().nextInt(26);
    if(index1>index2){
      // List<BarrageModel>  temps= barrageMOs.sublist(index2,index1);
      List<BarrageModel>  temps= barrageMOs.sublist(0,4);
      for(BarrageModel barrageMo in temps){
        addBarrage(barrageMo);
      }
    }else if(index1<index2){
      List<BarrageModel>  temps= barrageMOs.sublist(0,4);
      // List<BarrageModel>  temps= barrageMOs.sublist(index1,index2);
      for(BarrageModel barrageMo in temps){
        addBarrage(barrageMo);
      }
      // play();
    }

  }

  ///添加弹幕
  void addBarrage(BarrageModel model) {
    double perRowHeight=30;
    var line = _barrageIndex%widget.lineCount;
    _barrageIndex++;
    var top = line*perRowHeight+widget.top*(line-1);
    //为每条弹幕生成一个id
    String id ='${_random.nextInt(10000)}:${model.content}';
    var item=BarrageItem(id: id, top: top, child: BarrageViewUtil.barrageView(model),
      onComplete: _onComplete,
    );
    _barrageItemList.add(item);
    setState(() {

    });
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


  void _onComplete(id) {
    if (kDebugMode) {
      print('Done:$id');
    }
    //弹幕播放完毕将其从弹幕widget集合中剔除
    _barrageItemList.removeWhere((element) => element.id==id);
  }
}

