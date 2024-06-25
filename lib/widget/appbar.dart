import 'package:flutter/material.dart';
import 'package:flutter_bili_app/util/view_util.dart';

///自定义顶部appBar
appBar(String title, String rightTitle, VoidCallback rightButtonClick){
  return AppBar(
    //让title居左
    centerTitle: false,
    titleSpacing: 0,
    leading: const BackButton(),
    title: Text(title,style: TextStyle(fontSize: 18),),
    actions: [
      InkResponse(
        onTap: rightButtonClick,
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          alignment: Alignment.center,
          child: Text(rightTitle, style: TextStyle(fontSize: 18,color: Colors.grey[500]),textAlign: TextAlign.center,),
        ),
      )
    ],
  );
}

///视频详情页appBar
videoAppBar(){
  return Container(
    padding: const EdgeInsets.only(right: 8),
    margin: const EdgeInsets.only(top: 20),
    decoration: BoxDecoration(gradient: blackLinearGradient(fromTop: true)),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackButton(
          color: Colors.white,
        ),
        Row(
          children: [
            Icon(Icons.live_tv_rounded,color: Colors.white, size: 20,),
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Icon(Icons.more_vert_rounded, color: Colors.white, size: 20,),),
          ],
        ),
      ],
    ),
  );
}