import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
///页面状态异常管理
abstract class HiState<T extends StatefulWidget> extends State<T>{
  @override
  void setState(VoidCallback fn) {
    if(mounted){
      super.setState(fn);
    }else{
      if (kDebugMode) {
        print('HiState:页面已销毁，本次setState不执行：${toString()}');
      }
    }

  }
}