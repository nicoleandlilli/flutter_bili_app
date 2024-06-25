import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoView extends StatefulWidget{
  final String url;
  final String? cover;
  final bool autoPlay;
  final bool looping;
  final double aspectRatio;

  const VideoView(this.url, {super.key,this.cover, this.autoPlay=false, this.looping=false, this.aspectRatio=16/9});

  @override
  VideoViewState createState() => VideoViewState();

}

class VideoViewState extends State<VideoView> {
  late VideoPlayerController _videoPlayerController; //video_player播放器Controller
  late ChewieController _chewieController; //chewie播放器Controller
  final newUrl = ['https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
    "https://freetestdata.com/wp-content/uploads/2022/02/Free_Test_Data_10MB_MOV.mov",
  ];
  @override
  void initState() {
    super.initState();
    //初始化播放器设置
    _videoPlayerController=VideoPlayerController.networkUrl(Uri.parse(newUrl[8]));
    _initVideoPlayer();
    _chewieController=ChewieController(videoPlayerController: _videoPlayerController,
      aspectRatio: widget.aspectRatio,
      autoPlay: widget.autoPlay,
      looping: widget.looping,
    );
  }
  _initVideoPlayer() async{
    await _videoPlayerController.initialize();
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = screenWidth / widget.aspectRatio;
    return Container(
      width: screenWidth,
      height: screenHeight,
      color: Colors.grey,
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }

}