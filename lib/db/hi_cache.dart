import 'package:shared_preferences/shared_preferences.dart';

class HiCache{
  SharedPreferences?  prefs;
  static  HiCache? _instance;

  HiCache._(){
    init();
  }

  ///预初始化，防止在使用get时，prefs还未完成初始化
  static Future<HiCache> preInit() async{
    if(_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = HiCache._pre(prefs);
    }
    return _instance!!;
  }

  HiCache._pre(SharedPreferences this.prefs);



  static HiCache? getInstance(){
    _instance ??= HiCache._();
    return _instance;
  }

  void init() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  setString(String key, String value){
    prefs?.setString(key, value);
  }

  setDouble(String key, double value){
    if(prefs==null){
      _instance = HiCache._();
    }
    prefs?.setDouble(key, value);
  }

  setInt(String key, int value){
    if(prefs==null){
      _instance = HiCache._();
    }
    prefs?.setInt(key, value);
  }

  setBool(String key, bool value){
    if(prefs==null){
      _instance = HiCache._();
    }
    prefs?.setBool(key, value);
  }

  Object? get(String key){
    if(prefs==null){
      _instance = HiCache._();
    }
    return prefs?.get(key);
  }

}