import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/home_mo.dart';
import 'package:flutter_bili_app/widget/video_view.dart';

import '../util/view_util.dart';
import '../widget/appbar.dart';

class VideoDetailPage extends StatefulWidget{
  final VideoMo videoMo;


  const VideoDetailPage({super.key, required this.videoMo});
  // args: {'videoMo':VideoMo(tid:bannerMo.tid)}
  @override
  VideoDetailPageState createState() => VideoDetailPageState();

}

class VideoDetailPageState extends State<VideoDetailPage> {
  @override
  void initState() {
    super.initState();
    _statusBarInit();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(context: context, child: Column(
        children: [
          // if(Platform.isIOS)

          VideoView(widget.videoMo.shortLinkV2!,cover:widget.videoMo.pic, overlayUI: videoAppBar(),),
        ],
      )),
    );
  }

  void _statusBarInit() async{
    changeStatusBar(color: Colors.black,statusStyle:StatusStyle.lightContent);
  }

}
