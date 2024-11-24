import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static Future<SharedPreferences> init() async {
    return sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) {
    if (value is String) return sharedPreferences!.setString(key, value);
    if (value is int) return sharedPreferences!.setInt(key, value);
    if (value is bool) return sharedPreferences!.setBool(key, value);

    return sharedPreferences!.setDouble(key, value);
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences?.get(key);
  }

  static Future<Object?> removeData({
    required String key,
  }) async {
    return sharedPreferences?.remove(key);
  }

  static bool? isExist({
    required String key,
  }) {
    return sharedPreferences?.containsKey(key);
  }
}
