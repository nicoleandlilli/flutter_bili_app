import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/home_mo.dart';

class VideoCard extends StatelessWidget {
  final VideoMo videoMo;

  const VideoCard({super.key, required this.videoMo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if (kDebugMode) {
          print(videoMo?.url);
        }
      },
      child: Image.network(videoMo!.pic!),
    );
  }

}