import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bili_app/http/core/hi_net.dart';
import 'package:flutter_bili_app/http/request/home_rquest.dart';
import 'package:flutter_bili_app/model/home_mo.dart';

import '../../constant_value/constant_value.dart';

class HomeDao {
  static get(String categoryName,{int?  pageIndex, int? pageSize}) async{
    HomeRequest request = HomeRequest(categoryName,pageIndex: pageIndex, pageSize: pageSize);
    var result=await HiNet.getInstance().fire(request);
    if (kDebugMode) {
      print("home dao : $result");
    }

    // 解析 JSON 字符串为 Map
    Map<String, dynamic> homePage = jsonDecode(homePageJsonString);
    return HomeMo.fromJson(homePage['data']);
  }
}