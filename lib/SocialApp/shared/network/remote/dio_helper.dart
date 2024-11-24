import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio(BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        headers: {"Content-Type": "application/json"},
        receiveDataWhenStatusError: true));
  }

  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? query,
    bool isEnglish = false,
    String? token,
  }) async {
    dio?.options.headers = {
      "lang": isEnglish ? "en" : "ar",
      "Authorization": token,
      "Content-Type": "application/json"
    };
    return await dio!.get(path, queryParameters: query);
  }

  static Future<Response> postData({
    required String path,
    required dynamic data,
    bool isEnglish = false,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio?.options.headers = {
      "lang": isEnglish ? "en" : "ar",
      "Authorization": token,
      "Content-Type": "application/json"
    };
    return await dio!.post(path, data: data, queryParameters: query);
  }

  static Future<Response> putData({
    required String path,
    required dynamic data,
    bool isEnglish = false,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio?.options.headers = {
      "lang": isEnglish ? "en" : "ar",
      "Authorization": token,
      "Content-Type": "application/json"
    };
    return await dio!.put(path, data: data, queryParameters: query);
  }
}
