import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget{
  const FavoritePage({super.key});

  @override
  _FavoritePageState createState() => _FavoritePageState();

}


class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: const Text('收藏'),
      ),
    );
  }

}