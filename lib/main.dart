import 'package:flutter/material.dart';
import 'package:flutter_bili_app/http/dao/login_dao.dart';
import 'package:flutter_bili_app/navigator/hi_navigator.dart';
import 'package:flutter_bili_app/page/home_page.dart';
import 'package:flutter_bili_app/page/login_page.dart';
import 'package:flutter_bili_app/page/registration_page.dart';
import 'package:flutter_bili_app/page/video_detail_page.dart';
import 'package:flutter_bili_app/util/color.dart';

import 'db/hi_cache.dart';
import 'model/video_model.dart';

void main() {
  runApp(BiliApp());
}

// class BiliApp extends StatelessWidget {
//   BiliApp({super.key});
//   VoidCallback onJumpToLogin = (){};
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     HiCache.preInit();
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         // colorScheme: ColorScheme.fromSeed(seedColor: white),
//         primarySwatch: white,
//         useMaterial3: true,
//       ),
//       // home: const MyHomePage(title: 'Flutter Demo Home Page'),
//       home: RegistrationPage(onJumpToLogin: onJumpToLogin,),
//       // home: LoginPage(),
//     );
//   }
// }

class BiliApp extends StatefulWidget{
  const BiliApp({super.key});

  @override
  _BiliAppState createState() => _BiliAppState();

}

class _BiliAppState extends State<BiliApp> {

  final BiliRouteDelegate _routeDelegate = BiliRouteDelegate();


  @override
  Widget build(BuildContext context) {

    return FutureBuilder<HiCache>(
        future: HiCache.preInit(),
        builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot){
          //定义route
          var widget = snapshot.connectionState==ConnectionState.done?
          Router(
            routerDelegate: _routeDelegate,
          )
          :const Scaffold(body: Center(child: CircularProgressIndicator(),),);

          return MaterialApp(
            home: widget,
            theme: ThemeData(primarySwatch: white),
          );
        });
  }

}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
  with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  //为Navigator设置一个key，必要的时候可以通过navigatorKey.currentState来获取到NavigatorState对象
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>();
  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages=[];
  late VideoModel videoModel;


  @override
  Widget build(BuildContext context){
    var index=getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages=pages;
    if(index!=-1){
      //要打卡的页面在栈中已存在，则将该页面和它上面的所有页面进行出栈
      //tips 具体规则可以根据需要进行调整，这里要求栈中只允许有一个同样的页面的实例
      tempPages=tempPages.sublist(0,index);
    }
    var page;
    if(routeStatus==RouteStatus.home){
      //跳转首页时将栈中其它页面进行出栈，因为首页不可回退
      pages.clear();
      page=pageWrap(HomePage(
        onJumpToDetail: (videoModel) {
          this.videoModel = videoModel;
          notifyListeners();
        },
      ));
    }else if(routeStatus==RouteStatus.detail){
      page=pageWrap(VideoDetailPage(videoModel: videoModel,));
    }else if(routeStatus==RouteStatus.registration){
      page=pageWrap(RegistrationPage(onJumpToLogin: () {
        _routeStatus=RouteStatus.login;
        notifyListeners();
      },));
    }else if(routeStatus==RouteStatus.registration){
      page=pageWrap(RegistrationPage(onJumpToLogin: (){
        _routeStatus=RouteStatus.login;
        notifyListeners();
      },));
    }else if(routeStatus==RouteStatus.login){
      page=pageWrap(LoginPage());
    }

    //重新创建一个数组，否则pages因引用没有改变路由不会生效
    tempPages=[...tempPages,page];
    pages=tempPages;

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result){
        //在这里可以控制否可以返回
        if(!route.didPop(result)){
          return false;
        }
        return true;
      },
    );
  }

  RouteStatus get routeStatus{
    if(_routeStatus!=RouteStatus.registration&&!hasLogin){
      return _routeStatus = RouteStatus.login;
    }else if(videoModel!=null){
      return _routeStatus=RouteStatus.detail;
    }else{
      return _routeStatus;
    }
  }

  bool get hasLogin => LoginDao.getBoardingPass()!=null;

  @override
  Future<void> setNewRoutePath(BiliRoutePath path) async{

  }
}

class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = "/";

  BiliRoutePath.detail() : location = "/detail";
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   var result;
//
//   @override
//   void initState() {
//     super.initState();
//     HiCache.preInit();
//   }
//
//   void _incrementCounter() async{
//     // TestRequest request = TestRequest();
//     // request.addParam("aa", "ddd").addParam("bb","bbb").addParam("requestPrams", "kkkk");
//     // try {
//     //   result = await HiNet.getInstance().fire(request);
//     // }on NeedAuth catch(e){
//     //   if (kDebugMode) {
//     //     print(e);
//     //   }
//     // }on NeedLogin catch(e){
//     //   if (kDebugMode) {
//     //     print(e);
//     //   }
//     // }on HiNetError catch(e){
//     //   if (kDebugMode) {
//     //     print(e);
//     //   }
//     // }
//     // if (kDebugMode) {
//     //   print(result);
//     // }
//     // setState(() {
//     //   // This call to setState tells the Flutter framework that something has
//     //   // changed in this State, which causes it to rerun the build method below
//     //   // so that the display can reflect the updated values. If we changed
//     //   // _counter without calling setState(), then the build method would not be
//     //   // called again, and so nothing would appear to happen.
//     //   _counter++;
//     // });
//     // test2();
//     // test3();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
//
//   // void test2(){
//   //   HiCache.getInstance()?.setString("aa", "1234");
//   //   var value = HiCache.getInstance()?.get("aa");
//   //   print("value : $value");
//   // }
//
//   // void test3() async{
//   //   try {
//   //     var result = await LoginDao.registration(
//   //         'java', 'flutter', '264191 ', '1903170325025965 ');
//   //
//   //
//   //     // var result = await LoginDao.login(
//   //     //     'java', 'flutter');
//   //     print(result);
//   //   }on NeedAuth catch(e){
//   //     print(e);
//   //   }on HiNetError catch(e){
//   //     print(e);
//   //   }
//   // }
// }



