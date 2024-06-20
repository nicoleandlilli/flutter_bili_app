import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RankingPage extends StatefulWidget{
  const RankingPage({super.key});

  @override
  _RankingPageState createState() => _RankingPageState();

}


class _RankingPageState extends State<RankingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: const Text('排行'),
      ),
    );
  }

}