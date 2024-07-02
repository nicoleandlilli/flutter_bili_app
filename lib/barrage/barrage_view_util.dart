import 'package:flutter/material.dart';
import '../model/barrage_model.dart';

class BarrageViewUtil {
  //如果想定义弹幕样式，可以在这里根据弹幕的类型来定义
  static barrageView(BarrageModel model) {
    switch (model.type) {
      case 1:
        return _barrageType1(model);
    }
    // 文字超出部分显示省略号
    return Text(model.content, maxLines: 1,overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white));
  }

  static _barrageType1(BarrageModel model) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15)),
        child: Text(
          model.content,
          maxLines: 1,
          overflow: TextOverflow.ellipsis, // 文字超出部分显示省略号
          style: const TextStyle(color: Colors.deepOrangeAccent,),
        ),
      ),
    );
  }
}
