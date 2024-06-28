import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/home_mo.dart';
import 'package:flutter_bili_app/navigator/hi_navigator.dart';
import 'package:flutter_bili_app/util/format_util.dart';
import 'package:provider/provider.dart';

import '../util/view_util.dart';

///关联视频，视频列表卡片
class VideoLargeCard extends StatelessWidget {
  final VideoMo videoModel;

  const VideoLargeCard({super.key, required this.videoModel});

  @override
  Widget build(BuildContext context) {
    // var themeProvider = context.watch<ThemeProvider>();
    return GestureDetector(
      onTap: () {
        HiNavigator.getInstance()
            .onJumpTo(RouteStatus.detail, args: {"videoMo": videoModel});
      },
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
        padding: const EdgeInsets.only(bottom: 6),
        height: 106,
        decoration: BoxDecoration(border: borderLine(context)),
        child: Row(children: [
          _itemImage(context),
          // _buildContent(themeProvider),
          _buildContent(),
        ]),
      ),
    );
  }

  _itemImage(BuildContext context) {
    double height = 90;
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Stack(
        children: [
          cachedImage(videoModel.pic!,
              width: height * (16 / 9), height: height),
          Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  durationTransform(videoModel.duration!),
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ))
        ],
      ),
    );
  }

  // _buildContent(ThemeProvider themeProvider) {
  _buildContent() {
    // var textColor = themeProvider.isDark() ? Colors.grey : Colors.black87;
    return Expanded(
        child: Container(
      padding: const EdgeInsets.only(top: 5, left: 8, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            videoModel.title!,
            style: const TextStyle(fontSize: 12),
          ),
          _buildBottomContent()
        ],
      ),
    ));
  }

  _buildBottomContent() {
    return Column(
      children: [
        //作者
        _owner(),
        hiSpace(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                smallIconText(Icons.favorite_border_rounded, videoModel.stat?.favorite!),
                hiSpace(width: 5),
                smallIconText(Icons.ondemand_video, videoModel.stat?.view!),
                hiSpace(width: 5),
                smallIconText(Icons.list_alt, videoModel.stat?.reply!)
              ],
            ),
            const Icon(
              Icons.more_vert_sharp,
              color: Colors.grey,
              size: 15,
            )
          ],
        )
      ],
    );
  }

  _owner() {
    var owner = videoModel.owner;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: Colors.grey)),
          child: const Text(
            'UP',
            style: TextStyle(
                color: Colors.grey, fontSize: 8, fontWeight: FontWeight.bold),
          ),
        ),
        hiSpace(width: 8),
        Text(
          owner!.name!,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        )
      ],
    );
  }
}
