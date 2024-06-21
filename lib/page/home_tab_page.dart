import 'package:flutter/cupertino.dart';

class HomeTabPage extends StatefulWidget{
  String name;
  HomeTabPage({super.key,required this.name});

  @override
  _HomeTabPageState createState() => _HomeTabPageState();

}

class _HomeTabPageState extends State<HomeTabPage>{
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(widget.name),
    );
  }

}
