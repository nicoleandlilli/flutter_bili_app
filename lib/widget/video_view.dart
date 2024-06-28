import 'package:flutter/material.dart';
import 'package:flutter_bili_app/util/view_util.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart' hide MaterialControls;
import 'dart:math' as math;
import '../util/color.dart';
import 'hi_video_controls.dart';

class VideoView extends StatefulWidget{
  final String url;
  final String? cover;
  final bool autoPlay;
  final bool looping;
  final double aspectRatio;
  final Widget? overlayUI;

  const VideoView(this.url, {super.key,this.cover, this.autoPlay=false, this.looping=false, this.aspectRatio=16/9, this.overlayUI});

  @override
  VideoViewState createState() => VideoViewState();

}

class VideoViewState extends State<VideoView> {
  late VideoPlayerController _videoPlayerController; //video_player播放器Controller
  late ChewieController _chewieController; //chewie播放器Controller
  //封面
  get _placeholder => FractionallySizedBox(
    widthFactor: 1,
    child: cachedImage(widget.cover!),
  );
  var _newplaceholder;
  //进度条颜色配置
  get _progressColors => ChewieProgressColors(
    playedColor: primary,
    handleColor: primary,
    backgroundColor: Colors.grey,
    bufferedColor: Colors.pinkAccent,
  );
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
    _newplaceholder= _placeholder;
    var index = math.Random().nextInt(9);
    //初始化播放器设置
    _videoPlayerController=VideoPlayerController.networkUrl(Uri.parse(newUrl[index%9]));
    _initVideoPlayer();
    _chewieController=ChewieController(videoPlayerController: _videoPlayerController,
      aspectRatio: widget.aspectRatio,
      autoPlay: widget.autoPlay,
      looping: widget.looping,
      allowMuting: false,
      placeholder: _newplaceholder,
      allowPlaybackSpeedChanging: false,
      customControls: MaterialControls(
        showBigPlayIcon: false,
        showLoadingOnInitialize: false,
        bottomGradient: blackLinearGradient(),
        overlayUI: widget.overlayUI,
      ),
      materialProgressColors: _progressColors,
    );
  }
  _initVideoPlayer(){
    _videoPlayerController.initialize().then((value) => {
      setState(() {

      })
    });
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
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

}