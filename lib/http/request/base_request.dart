enum HttpMethod { GET, POST, DELETE }
//基础请求

abstract class BaseRequest{
  // curl -X GET "http://api.devio.org/uapi/test/test?requestPrams=11"
  // curl -X GET "http://api.devio.org/uapi/test/test/test/1"

  var pathParams;
  var useHtpps=true;

  String authority(){
    return "api.devio.org";
  }

  HttpMethod httpMethod();

  String path();

  String url(){
    Uri uri;
    var pathStr=path();
    //拼接path参数
    if(pathParams!=null){
      if(path().endsWith(("/"))){
        pathStr = "${path()}$pathParams";
      }else{
        pathStr = "${path()}/$pathParams";
      }
    }
    //http和https切换
    if(useHtpps){
      uri=Uri.https(authority(),pathStr,params);
    }else{
      uri=Uri.http(authority(),pathStr,params);
    }

    print('url:${uri.toString()}');
    return uri.toString();
  }

  bool needLogin();

  Map<String, String> params= {};

  //添加参数
  BaseRequest addParam(String k, Object v){
    params[k] = v.toString();
    return this;
  }


  Map<String, String> header= {};

  //添加header
  BaseRequest addHeader(String k, Object v){
    header[k] = v.toString();
    return this;
  }

}