
import 'package:flutter_bili_app/http/core/hi_net_adapter.dart';
import 'package:flutter_bili_app/http/request/base_request.dart';

class MockAdapter extends HiNetAdapter {

  @override
  Future<HiNetResponse<dynamic>> send<T>(BaseRequest request) {
      return Future<HiNetResponse>.delayed(Duration(microseconds: 1000), (){
        return HiNetResponse(
          // data: {"code":0,"message":"success"},
          // statusCode: 200

            data: {"code":0,"message":"success"},
            statusCode: 403
        );
      });
    }


}