import 'package:flutter/material.dart';
import 'package:flutter_bili_app/navigator/hi_navigator.dart';
import 'package:flutter_bili_app/provider/theme_provider.dart';
import 'package:flutter_bili_app/util/color.dart';
import 'db/hi_cache.dart';
///查看Bilibili API地址的网址：
///https://socialsisteryi.github.io/bilibili-API-collect/#%F0%9F%8D%B4%E7%9B%AE%E5%BD%95

///推荐界面实际打开网址：
///https://api.bilibili.com/x/web-interface/ranking/v2

void main() {
  runApp(const BiliApp());
}

class BiliApp extends StatefulWidget {
  const BiliApp({super.key});

  @override
  BiliAppState createState() => BiliAppState();
}

class BiliAppState extends State<BiliApp> {
  final BiliRouteDelegate _routeDelegate = BiliRouteDelegate();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HiCache>(
        future: HiCache.preInit(),
        builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
          //定义route
          var widget = snapshot.connectionState == ConnectionState.done
              ? Router(
                  routerDelegate: _routeDelegate,
                )
              : const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );

          return MaterialApp(
            home: widget,
            // theme: ThemeData(primarySwatch: white),
            theme: ThemeProvider().getTheme(),
            darkTheme: ThemeProvider().getTheme(isDarkMode: true),
            themeMode: ThemeProvider().getThemeMode(),
          );
        });
  }


}





//   // void test2(){
//   //   HiCache.getInstance()?.setString("aa", "1234");
//   //   var value = HiCache.getInstance()?.get("aa");
//   //   print("value : $value");
//   // }


///6----6

