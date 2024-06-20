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


//   // void test2(){
//   //   HiCache.getInstance()?.setString("aa", "1234");
//   //   var value = HiCache.getInstance()?.get("aa");
//   //   print("value : $value");
//   // }




