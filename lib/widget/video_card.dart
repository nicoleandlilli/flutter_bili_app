import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/home_mo.dart';
import 'package:flutter_bili_app/navigator/hi_navigator.dart';
import 'package:flutter_bili_app/util/format_util.dart';
import 'package:transparent_image/transparent_image.dart';

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
        HiNavigator.getInstance().onJumpTo(RouteStatus.detail,args: {"videoMo":videoMo});
      },
      // child: Image.network(videoMo!.pic!),
      child: SizedBox(
        height: 200,
        child: Card(
          //取消卡片默认边距
          margin: const EdgeInsets.only(left: 4, right: 4, bottom: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _itemImage(context),
                _infoText(),
              ],
            ),
          ),  
        ),
        
      ),
    );
  }

  _itemImage(context){
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        FadeInImage.memoryNetwork(
          height: 120,
          //默认宽度
          width: size.width/2-20,
          placeholder: kTransparentImage,
           image: videoMo!.pic!,
          fit: BoxFit.cover,),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: 3,
                top: 5,
              ),
              decoration: const BoxDecoration(
                //渐变
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black54, Colors.transparent],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _iconText(Icons.ondemand_video,videoMo!.stat!.view!),
                  _iconText(Icons.favorite_border,videoMo!.stat!.favorite!),
                  _iconText(null,videoMo!.duration!),
                ],
              ),
            )),

      ],
    );
  }

  _iconText(IconData? iconData, int count) {
    String views="";
    if(iconData!=null){
      views=countFormat(count);
    }else{
      views=durationTransform(videoMo!.duration!);
    }

    return Row(
      children: [
        if(iconData!=null)
          Icon(iconData,color: Colors.white,size: 12,),
        Padding(padding: const EdgeInsets.only(left: 3),
        child: Text(views,style: const TextStyle(color: Colors.white,fontSize: 10),),),
      ],
    );
  }
  
  _infoText(){
    return Expanded(child: Container(
      padding: const EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(videoMo.title!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
          _owner(),
        ],
      ),
    ));
  }

  _owner() {
    var owner=videoMo.owner;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(owner!.face!,width: 24, height: 24,),
            ),
            Padding(padding: const EdgeInsets.only(left: 8),
            child: Text(owner.name!, style: const TextStyle(fontSize: 11, color: Colors.black87),),
            ),
          ],
        ),
        const Icon(
          Icons.more_vert_sharp,
          size: 15,
            color: Colors.grey,
        )
      ],
    );
  }

}

