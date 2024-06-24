import 'package:flutter/material.dart';
import 'package:flutter_bili_app/navigator/hi_navigator.dart';
import 'package:flutter_bili_app/util/color.dart';
import 'db/hi_cache.dart';

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
            theme: ThemeData(primarySwatch: white),
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

