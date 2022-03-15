import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static late Dio dio;

  static int() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
          receiveDataWhenStatusError: true,
          ),
    );
  }

  static Future<Response> getData(
      {
        String lang = "en",
      String? authToken,
      @required String? url,
   Map<String, dynamic>? query}) async {
    dio.options.headers = {
      "lang": lang,
      "Authorization": authToken??'',
      "Content-Type": 'application/json',
    };
    return await dio.get(url!, queryParameters: query);
  }

  static Future<Response> postData({
    String lang = "en",
    String? authToken,
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      "Content-Type": 'application/json',
      "lang": lang,
      "Authorization": authToken,

    };
    return await dio.post(url, queryParameters: query, data: data);
  }
}
