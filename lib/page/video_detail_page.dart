import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/home_mo.dart';
import 'package:flutter_bili_app/widget/video_view.dart';

class VideoDetailPage extends StatefulWidget{
  final VideoMo videoMo;


  const VideoDetailPage({super.key, required this.videoMo});
  // args: {'videoMo':VideoMo(tid:bannerMo.tid)}
  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();

}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: VideoView(widget.videoMo.shortLinkV2!,cover:widget.videoMo.pic,),
    );
  }

}