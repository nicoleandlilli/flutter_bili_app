import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_app/page/login_page.dart';
import 'package:flutter_bili_app/page/registration_page.dart';

import '../http/dao/login_dao.dart';
import '../model/video_model.dart';
import '../page/home_page.dart';
import '../page/video_detail_page.dart';
import '../util/toast.dart';
import 'bottom_navigator.dart';

typedef RouteChangeListener = Function(RouteStatusInfo current, RouteStatusInfo pre);
///创建界面
pageWrap(Widget child){
  return MaterialPage(key: ValueKey(child.hashCode),child: child);
}

///获取routeStatus在页面栈中的位置
int getPageIndex(List<MaterialPage>pages, RouteStatus routeStatus){
  for(int i=0;i<pages.length;i++){
    MaterialPage page = pages[i];
    if(getStatus(page)==routeStatus){
      return i;
    }
  }
  return -1;
}

///自定义路由封装，路由状态
enum RouteStatus { login, registration, home, detail, unknown}

///获取page对应的RouteStatus
RouteStatus getStatus(MaterialPage page){
  if(page.child is LoginPage){
    return RouteStatus.login;
  }else if(page.child is RegistrationPage){
    return RouteStatus.registration;
  } else if(page.child is BottomNavigationBar){
    return RouteStatus.home;
  }else if(page.child is VideoDetailPage){
    return RouteStatus.detail;
  }
  else{
    return RouteStatus.unknown;
  }
}

///路由信息
class RouteStatusInfo{
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}


///监听路由页面跳转
///感知当前页面是否压后台
class HiNavigator extends _RouteJumpListener{
  static HiNavigator? _instance;
  RouteJumpListener? _routeJumpListener;
  ///所有页面注册的页面跳转listener的集合
  List<RouteChangeListener>_listeners=[];
  ///打开过的页面
  RouteStatusInfo? _current;
  HiNavigator._();

  static HiNavigator getInstance(){
    _instance ??= HiNavigator._();
    return _instance!;
  }


  ///注册路由跳转逻辑
  void registerRouteJump(RouteJumpListener routeJumpListener){
    _routeJumpListener = routeJumpListener;
  }

  ///添加监听路由页面跳转
  void addListener(RouteChangeListener listener){
    if(!_listeners.contains(listener)){
      _listeners.add(listener);
    }
  }

  ///移除监听路由页面跳转
  void removeListener(RouteChangeListener listener){
    _listeners.remove(listener);
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map? args}) {
    _routeJumpListener!.onJumpTo!(routeStatus, args: args);
  }

  ///通知路由页面变化
  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages){
    if(currentPages==prePages) return;
    var current = RouteStatusInfo(getStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  void _notify(RouteStatusInfo current){
    if (kDebugMode) {
      print('hi_navigator:current:${current.page}');
    }
    if (kDebugMode) {
      print('hi_navigator:pre:${_current?.page}');
    }
    for (var listener in _listeners) {
      listener(current,_current!);
    }
    _current = current;
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
      // page = pageWrap(const HomePage());
      page = pageWrap( BottomNavigator());
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(
        videoModel: videoModel!,
      ));
    } else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(const RegistrationPage());
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(const LoginPage());
    }

    //重新创建一个数组，否则pages因引用没有改变路由不会生效
    tempPages = [...tempPages, page];
    //通知路由发生变化
    HiNavigator.getInstance().notify(tempPages, pages);
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

            var tempPages=[...pages];
            pages.removeLast();
            HiNavigator.getInstance().notify(pages, tempPages);
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