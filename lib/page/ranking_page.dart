import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_app/util/view_util.dart';
import 'package:flutter_bili_app/widget/hi_tab.dart';

import '../widget/navigation_bar.dart';

class RankingPage extends StatefulWidget{
  const RankingPage({super.key});

  @override
  RankingPageState createState() => RankingPageState();

}


class RankingPageState extends State<RankingPage> with TickerProviderStateMixin{
  static const tabs = [
    {"key": "like","name": "最热"},
    {"key": "pub date","name": "最新"},
    {"key": "favorite","name": "收藏"},
  ];

  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller=TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildNavigationBar(),
          _buildTabView(),
        ],
      ),
    );
  }

  _buildNavigationBar() {
    return CNavigationBar(
      child: Container(
        alignment: Alignment.center,
        child: _tabBar(),
        decoration: bottomBoxShadow(),
      ),

    );
  }

  _tabBar() {
    return HiTab(
      tabs.map<Tab>((tab) {
        return Tab(
          text: tab['name'],
        );
      }).toList(),
      fontSize: 16,
      borderWidth: 3,
      unselectedLabelColor: Colors.black54,
      controller: _controller,
    );
  }

  _buildTabView() {
    return Flexible(
        child: TabBarView(
          controller: _controller,
          children: tabs.map((tab) {
            return Text(tab['name']!);
          }).toList(),

        ),
    );
  }

}