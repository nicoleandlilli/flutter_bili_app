import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/home_mo.dart';
import 'package:flutter_bili_app/util/color.dart';
import 'package:flutter_bili_app/util/format_util.dart';
import 'package:flutter_bili_app/util/view_util.dart';

///视频点赞分享收藏等工具栏

class VideoToolBar extends StatelessWidget {
  final VideoMo videoMo;
  final VoidCallback? onLike;
  final VoidCallback? onUnLike;
  final VoidCallback? onCoin;
  final VoidCallback? onFavorite;
  final VoidCallback? onShare;

  const VideoToolBar({super.key, required this.videoMo, this.onLike, this.onUnLike, this.onCoin, this.onFavorite, this.onShare});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: borderLine(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIconText(Icons.thumb_up_alt_rounded,videoMo.stat?.like,onClick: onLike, tint: videoMo.stat!.hisRank!>=2)
        ],
      ),
    );
  }

  _buildIconText(IconData iconData, text, {onClick, bool tint = false}){
    if(text is int){
      //显示格式化
      text = countFormat(text);
    }else {
      text ??= '';
    }

    return InkWell(
      onTap: onClick,
      child: Column(
        children: [
          Icon(iconData, color: tint?primary:Colors.grey,),
          hiSpace(height: 5),
          Text(text, style: const TextStyle(color: Colors.grey, fontSize: 12),),
        ],
      ),
    );

  }

}