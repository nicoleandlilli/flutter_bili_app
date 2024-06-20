import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_app/main.dart';
import 'package:flutter_bili_app/navigator/hi_navigator.dart';

import '../model/video_model.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  _HomePageState createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage>{
  var listener;
  @override
  void initState() {
    super.initState();
    HiNavigator.getInstance().addListener(listener = (current, pre) {
      if (kDebugMode) {
        print('current:${current.page}');
      }
      if (kDebugMode) {
        print('pre:${pre.page}');
      }
    });
  }
  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(listener);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(),
     body: Container(
       child: Column(
         children: [
           const Text('首页'),
           MaterialButton(
               onPressed: () {
                 if (kDebugMode) {
                   print("点击了详情按钮");
                 }
                HiNavigator.getInstance().onJumpTo(RouteStatus.detail,
                  args: {'videoMo': VideoModel(10001)});
               },
             child: const Text("详情"),
           ),
         ],
       ),
     ),
   );
  }
  
}