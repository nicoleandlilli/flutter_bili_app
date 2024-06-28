import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/home_mo.dart';
import 'package:flutter_bili_app/util/view_util.dart';

///职场进阶
class CourseCard extends StatelessWidget {
  final List<VideoMo> courseList;

  const CourseCard({super.key, required this.courseList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 5, top: 15),
      child: Column(
        children: [_buildTitle(), ..._buildCardList(context)],
      ),
    );
  }

  _buildTitle() {
    return Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            const Text('分组视频',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            hiSpace(width: 10),
            Text(
              '',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            )
          ],
        ));
  }

  ///动态布局
  _buildCardList(BuildContext context) {
    var courseGroup = {};
    //将课程进行分组
    for (var mo in courseList) {
      if (!courseGroup.containsKey(mo.tname)) {
        courseGroup[mo.tname] = [];
      }
      List list = courseGroup[mo.tname];
      list.add(mo);
    }
    return courseGroup.entries.map((e) {
      List list = e.value;
      //根据卡片数量计算出每个卡片的宽度
      var width =
          (MediaQuery.of(context).size.width - 20 - (list.length - 1) * 5) /
              list.length;
      var height = width / 16 * 6;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [...list.map((mo) => _buildCard(mo, width, height)).toSet()],
      );
    });
  }

  _buildCard(VideoMo mo, double width, double height) {
    return InkWell(
      onTap: () {
        //todo
        print('跳转到H5');
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 5, bottom: 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: cachedImage(mo.pic!, width: width, height: height),
        ),
      ),
    );
  }
}
