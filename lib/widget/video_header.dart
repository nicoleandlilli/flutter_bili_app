import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/home_mo.dart';
import 'package:flutter_bili_app/util/color.dart';
import 'package:flutter_bili_app/util/format_util.dart';

///详情页的widget
class VideoHeader extends StatelessWidget {
  final Owner owner;
  final Stat stat;

  const VideoHeader({super.key, required this.owner, required this.stat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, right: 15,left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(owner.face!, width: 30, height: 30,),
              ),
              Padding(padding: const EdgeInsets.only(left: 8),
              child: Column(
                children: [
                  Text(owner.name!,style: const TextStyle(fontSize: 13,color: primary,fontWeight: FontWeight.bold),),
                  Text('${countFormat(stat.like!)}粉丝',style: const TextStyle(fontSize: 10, color: Colors.grey),)
                ],
              ),),
            ],
          ),
          MaterialButton(
            onPressed: (){
                print('------------关注');
            },
            color: primary,
            height: 24,
            minWidth: 50,
            child: const Text(
              '+关注',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13
              ),
            ),
          ),

        ],
      ),
    );
  }

}