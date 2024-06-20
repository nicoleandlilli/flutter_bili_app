import 'package:flutter/material.dart';

import '../model/video_model.dart';


class HomePage extends StatefulWidget {
  final ValueChanged<VideoModel>onJumpToDetail;

  const HomePage({super.key,  required this.onJumpToDetail}) ;

  @override
  _HomePageState createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(),
     body: Container(
       child: Column(
         children: [
           Text('首页'),
           MaterialButton(
               onPressed: ()=>widget.onJumpToDetail(VideoModel(111)),
             child: Text("详情"),
           ),
         ],
       ),
     ),
   );
  }
  
}