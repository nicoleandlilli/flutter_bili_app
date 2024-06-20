import 'package:flutter/material.dart';
import 'package:flutter_bili_app/http/dao/login_dao.dart';
import 'package:flutter_bili_app/navigator/hi_navigator.dart';
import 'package:flutter_bili_app/page/home_page.dart';
import 'package:flutter_bili_app/page/login_page.dart';
import 'package:flutter_bili_app/page/registration_page.dart';
import 'package:flutter_bili_app/page/video_detail_page.dart';
import 'package:flutter_bili_app/util/color.dart';
import 'package:flutter_bili_app/util/toast.dart';

import 'db/hi_cache.dart';
import 'model/video_model.dart';

void main() {
  runApp(BiliApp());
}

class BiliApp extends StatefulWidget {
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

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  //为Navigator设置一个key，必要的时候可以通过navigatorKey.currentState来获取到NavigatorState对象
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>(){
    //实现路由跳转逻辑
    HiNavigator.getInstance().registerRouteJump(RouteJumpListener(onJumpTo: (RouteStatus routeStatus,{Map? args}){
      _routeStatus = routeStatus;
      if(routeStatus == RouteStatus.detail){
        videoModel = args?['videoMo'];
      }
      notifyListeners();
    }));
  }

  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];
  VideoModel? videoModel;

  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      //要打卡的页面在栈中已存在，则将该页面和它上面的所有页面进行出栈
      //tips 具体规则可以根据需要进行调整，这里要求栈中只允许有一个同样的页面的实例
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    if (routeStatus == RouteStatus.home) {
      //跳转首页时将栈中其它页面进行出栈，因为首页不可回退
      pages.clear();
      page = pageWrap(const HomePage());
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(
        videoModel: videoModel!,
      ));
    } else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(RegistrationPage(
        onJumpToLogin: () {
          _routeStatus = RouteStatus.login;
          notifyListeners();
        },
      ));
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage(
        onSuccess: () {
          _routeStatus = RouteStatus.home;
          notifyListeners();
        },
        onJumpRegistration: () {
          _routeStatus = RouteStatus.registration;
          notifyListeners();
        },
      ));
    }

    //重新创建一个数组，否则pages因引用没有改变路由不会生效
    tempPages = [...tempPages, page];
    pages = tempPages;


    //fix Android 物理返回键，无法返回上一页问题@http://github.com/flutter/flutter/issues/66349
    return WillPopScope(

        onWillPop: () async {
          var res =  !await navigatorKey.currentState!.maybePop();
          return res;
        },
        child: Navigator(
          key: navigatorKey,
          pages: pages,
          onPopPage: (route, result) {
            if(route.settings is MaterialPage){
              //登录页未登录返回拦截
              if((route.settings as MaterialPage).child is LoginPage){
                if(!hasLogin){
                  showToast("请先登录");
                  return false;
                }
              }
            }

            //执行返回操作
            //在这里可以控制否可以返回
            if (!route.didPop(result)) {
              return false;
            }

            pages.removeLast();
            return true;
          },
        ));

    // return Navigator(
    //   key: navigatorKey,
    //   pages: pages,
    //   onPopPage: (route, result){
    //     //在这里可以控制否可以返回
    //     if(!route.didPop(result)){
    //       return false;
    //     }
    //     return true;
    //   },
    // );
  }

  RouteStatus get routeStatus {
    if (_routeStatus != RouteStatus.registration && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else if (videoModel != null) {
      return _routeStatus = RouteStatus.detail;
    } else {
      return _routeStatus;
    }
  }

  bool get hasLogin => LoginDao.getBoardingPass() != null;

  @override
  Future<void> setNewRoutePath(BiliRoutePath path) async {}

}

class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = "/";

  BiliRoutePath.detail() : location = "/detail";
}

///监听路由页面跳转
///感知当前页面是否压后台
class HiNavigator extends _RouteJumpListener{
  static HiNavigator? _instance;
  RouteJumpListener? _routeJumpListener;
  HiNavigator._();

  static HiNavigator getInstance(){
    _instance ??= HiNavigator._();
    return _instance!;
  }

  ///注册路由跳转逻辑
  void registerRouteJump(RouteJumpListener routeJumpListener){
    _routeJumpListener = routeJumpListener;
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map? args}) {
    _routeJumpListener!.onJumpTo!(routeStatus, args: args);
  }

}

///抽象类供HiNavigator实现
abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map? args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map? args});

///定义路由跳转逻辑要实现的功能
class RouteJumpListener {
  final OnJumpTo? onJumpTo;

  RouteJumpListener({this.onJumpTo});
}

//   // void test2(){
//   //   HiCache.getInstance()?.setString("aa", "1234");
//   //   var value = HiCache.getInstance()?.get("aa");
//   //   print("value : $value");
//   // }


///5----7

