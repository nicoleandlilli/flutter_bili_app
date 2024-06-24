import 'package:flutter_bili_app/http/request/base_request.dart';
import 'package:flutter_bili_app/http/request/custom_base_request.dart';

class HomeRequest extends CustomBaseRequest{
  final String? categoryName;
  final int? pageIndex;
  final int? pageSize;

  HomeRequest(this.categoryName,{this.pageIndex, this.pageSize}):super();

  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return 'x/web-interface/ranking/v2';
  }

}