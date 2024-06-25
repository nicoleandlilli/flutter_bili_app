import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:status_bar_control/status_bar_control.dart';

enum StatusStyle { lightContent, darkContent }

///带缓存的image
Widget cachedImage(String url, {double? width, double? height}) {
  return CachedNetworkImage(
      height: height,
      width: width,
      fit: BoxFit.cover,
      placeholder: (
        BuildContext context,
        String url,
      ) =>
          Container(color: Colors.grey[200]),
      errorWidget: (
        BuildContext context,
        String url,
        dynamic error,
      ) =>
          const Icon(Icons.error),
      imageUrl: url);
}

///黑色线性渐变
blackLinearGradient({bool fromTop = false}) {
  return LinearGradient(
      begin: fromTop ? Alignment.topCenter : Alignment.bottomCenter,
      end: fromTop ? Alignment.bottomCenter : Alignment.topCenter,
      colors: const [
        Colors.black54,
        Colors.black45,
        Colors.black38,
        Colors.black26,
        Colors.black12,
        Colors.transparent
      ]);
}
///修改状态栏
void changeStatusBar (
    {color = Colors.white,
    StatusStyle statusStyle = StatusStyle.darkContent,
    BuildContext? context}) async{
  //沉浸式状态栏样式
  Brightness brightness;
  if (Platform.isIOS) {
    brightness = statusStyle == StatusStyle.lightContent
        ? Brightness.dark
        : Brightness.light;
  } else {
    brightness = statusStyle == StatusStyle.lightContent
        ? Brightness.light
        : Brightness.dark;
  }
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
  //   statusBarColor: Colors.transparent,
  //   statusBarBrightness: brightness,
  //   statusBarIconBrightness: brightness,
  // ));

  //沉浸式状态栏样式
  StatusBarControl.setColor(color,animated: false);
  //设置状态栏文字的颜色
  await StatusBarControl.setStyle(statusStyle==StatusStyle.darkContent?StatusBarStyle.DARK_CONTENT:StatusBarStyle.LIGHT_CONTENT);
}
