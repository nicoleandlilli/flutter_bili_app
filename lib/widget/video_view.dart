// import 'package:flutter/cupertino.dart';
// import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';
//
// class VideoView extends StatefulWidget{
//   final String url;
//   final String? cover;
//   final bool autoPlay;
//   final bool looping;
//   final double aspectRatio;
//   const VideoView(this.url, {super.key,this.cover, this.autoPlay=false, this.looping=false, this.aspectRatio=16/9});
//
//   @override
//   VideoViewState createState() => VideoViewState();
//
// }
//
// class VideoViewState extends State<VideoView> {
//   late VideoPlayerController _videoPlayerController; //video_player播放器Controller
//   late ChewieController _chewieController; //chewie播放器Controller
//
//   @override
//   void initState() {
//     super.initState();
//     //初始化播放器设置
//     _videoPlayerController=VideoPlayerController.networkUrl(Uri.parse(widget.url));
//     _chewieController=ChewieController(videoPlayerController: _videoPlayerController,
//       aspectRatio: widget.aspectRatio,
//       autoPlay: widget.autoPlay,
//       looping: widget.looping,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _videoPlayerController.dispose();
//     _chewieController.dispose();
//   }
//
// }