
// 请求方法

import 'package:dio/dio.dart';
import 'dart:async';
import './service_url.dart';
import './http_headers.dart';

class DioUtil {
  static Dio dio = new Dio();
  static Future requestData(url, {formData}) async {
    try {
      Response response;
      dio.options.headers = httpHeaders;
      if (formData == null) {
        response = await dio.post(servicePath[url]);
      } else {
        response = await dio.post(servicePath[url], queryParameters:formData);
      }
      if (response.statusCode == 200) {
        return response.data; 
      } else {
        throw Exception("接口异常");
      }
    } catch(e) {
      print("网络出现错误");
    }
  }

  // 拦截器部分
  static tokenInter() {
    dio.interceptors.add(InterceptorsWrapper (
      onRequest:(RequestOptions options){
        // 在发送请求之前做一些预处理
        //比如在发送前到SharedPreferences（本地存储）中取出token的值，然后添加到请求头中
        //dio.lock()是先锁定请求不发送出去，当整个取值添加到请求头后再dio.unlock()解锁发送出去
        dio.lock();
        // Future<dynamic> future = Future(()async{
        //     SharedPreferences prefs = await SharedPreferences.getInstance();
        //     return prefs.getString("loginToken");
        // });
        // return future.then((value) {
        //     options.headers["Authorization"] = value;
        //     return options;
        // }).whenComplete(() => dio.unlock()); // unlock the dio
      },
      onResponse:(Response response) {
        // 在返回响应数据之前做一些预处理
        return response; // continue
      },
      onError:(DioError e) {
        // 当请求失败时做一些预处理
        return e;//continue
      }
    ));
  }
}
