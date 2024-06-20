import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/video_model.dart';

class VideoDetailPage extends StatefulWidget{
  final VideoModel videoModel;

  const VideoDetailPage({super.key, required this.videoModel});

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();

}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text('视频详情页，vid:${widget.videoModel.vid}'),
      ),
    );
  }

}