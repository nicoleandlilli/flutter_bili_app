import 'package:flutter/material.dart';
import 'package:flutter_bili_app/util/color.dart';
import 'package:flutter_bili_app/util/hi_constants.dart';

import '../db/hi_cache.dart';

extension ThemeModeExtension on ThemeMode{
  String get value => <String>['System','Light','Dark'][index];
}
class ThemeProvider extends ChangeNotifier{
  late ThemeMode _themeMode;
  ///获取主题模式
  ThemeMode getThemeMode(){
    var theme=HiCache.getInstance()?.get(HiConstants.theme);
    switch(theme){
      case 'Dark':
        _themeMode=ThemeMode.dark;
        break;
      case 'System':
        _themeMode=ThemeMode.system;
        break;
      default:
        _themeMode=ThemeMode.light;
        break;
    }
    return _themeMode=ThemeMode.dark;
  }

  ///设置主题
  void setTheme(ThemeMode themeMode){
    HiCache.getInstance()?.setString(HiConstants.theme, themeMode.value);
    notifyListeners();
  }

  ///获取主题方法
  ThemeData getTheme({bool isDarkMode=false}){
    var themeData=ThemeData(
      brightness: isDarkMode?Brightness.dark:Brightness.light,
      errorColor: isDarkMode?HiColor.darkRed:HiColor.red,
      primaryColor: isDarkMode?HiColor.darkBg:white,
      // accentColor: isDarkMode?primary[50]:white,
      hintColor: isDarkMode?primary[50]:white,
      //Tab指示器的颜色
      indicatorColor: isDarkMode?primary[50]:white,
      //页面背景色
      scaffoldBackgroundColor: isDarkMode?HiColor.darkBg:white,

    );

    return themeData;
  }

}