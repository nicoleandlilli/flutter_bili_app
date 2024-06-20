import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_app/page/login_page.dart';
import 'package:flutter_bili_app/page/registration_page.dart';

import '../page/home_page.dart';
import '../page/video_detail_page.dart';

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