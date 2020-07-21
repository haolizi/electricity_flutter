/*
 * -------请求简单封装-------
 * 由于所有接口是POST请求，就写死了请求方式
 */

import 'package:dio/dio.dart';
import 'dart:async';
import './service_url.dart';

class DioUtil {
  static BaseOptions options = BaseOptions(
    baseUrl: null,
    connectTimeout: 15000,
    responseType: ResponseType.plain,
    receiveTimeout: 15000,
    headers: null,
    contentType: "application/x-www-form-urlencoded",
  );

  static Dio dio = new Dio(options);
  static Future requestData(url, {formData}) async {
    try {
      Response response;
      if (formData == null) {
        response = await dio.post(servicePath[url]);
      } else {
        response = await dio.request(
          servicePath[url],
          data: formData,
          queryParameters: {},
          options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: {},
          ),
        );
      }
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("接口异常");
      }
    } catch (e) {
      print("网络出现错误");
    }
  }
}
