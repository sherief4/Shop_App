import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPrefs;

  static Future<void> init() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({
    required String key,
    required dynamic value,
  }) async{
    if (value is bool) {
      return await sharedPrefs.setBool(key, value);
    }
    if (value is String) {
      return await sharedPrefs.setString(key, value);
    }
    if (value is int) {
      return await  sharedPrefs.setInt(key, value);
    }
    if (value is double) {
      return await sharedPrefs.setDouble(key, value);
    }else{
      return await sharedPrefs.setStringList(key, value);
    }
  }

  static dynamic getData(String key)  {
    return  sharedPrefs.get(key);
  }

  static Future <bool> removeData (String key)async{
    return await sharedPrefs.remove(key);
  }
}
