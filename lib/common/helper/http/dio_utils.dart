import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import '../../../config/config.dart';
import 'base_response.dart';
import 'dio_wrapper.dart';
import 'dio_intercept.dart' as interceptor;

class HttpUtils {
  static final HttpUtils _instance = HttpUtils._();
  static HttpUtils get instance => HttpUtils();
  factory HttpUtils() => _instance;

  static late Dio _dio;
  Dio get dio => _dio;

  get header => _headers;
  final Map<String, dynamic> _headers = {};

  HttpUtils._() {
    final BaseOptions options = BaseOptions(
      connectTimeout: Config.connectTimeout,
      receiveTimeout: Config.receiveTimeout,
      sendTimeout: 10000,
      responseType: ResponseType.plain,
      validateStatus: (_) => true,
      baseUrl: Config.baseUrl,
      headers: _headers,
      contentType: "application/x-www-form-urlencoded",
    );

    // 实例化 Dio
    _dio = Dio(options);
    // 忽略https 证书校验问题
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    // 添加迭代器
    _dio.interceptors.add(interceptor.AuthInterceptor());
    if (kDebugMode) {
      _dio.interceptors.add(interceptor.LogInterceptor());
    }

    /// 开启日志打印
    /// 需要打印日志的接口在接口请求前 HttpUtils.instance?.openLog();
    void openLog() {
      _dio.interceptors
          .add(LogInterceptor(responseHeader: false, responseBody: true));
    }
  }

  updateHeader() {
    _dio.options.headers = _headers;
  }

  Future<BaseResponse> _request(
    String url, {
    String? method = 'POST',
    dynamic params,
    bool tips = false,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    late BaseResponse response;
    try {
      if (tips) {
        SVProgressHUD.show();
      }
      late Response<dynamic> res;
      if (method == 'GET') {
        res = await _dio.get(url, queryParameters: params);
      } else if (method == 'UPLOAD') {
        FormData formData = FormData.fromMap(params);
        res = await _dio.post(
          url,
          data: formData,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );
      } else {
        res = await _dio.post(
          url,
          data: params,
        );
      }
      response = DioWrapper.responseWrapper(res);
    } catch (e) {
      response = DioWrapper.errorWrapper(e);
    } finally {
      SVProgressHUD.dismiss();
    }
    return response;
  }

  // GET
  Future<BaseResponse> get(
    String url, {
    dynamic params,
    bool tips = false,
  }) async {
    return _request(
      url,
      method: 'GET',
      params: params,
      tips: tips,
    );
  }

  // POST
  Future<BaseResponse> post(
    String url, {
    dynamic params,
    bool tips = false,
  }) async {
    return _request(
      url,
      method: 'POST',
      params: params,
      tips: tips,
    );
  }

  // UPLOAD
  Future<BaseResponse> upload(
    String url, {
    dynamic params,
    bool tips = false,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return _request(
      url,
      method: 'UPLOAD',
      params: params,
      tips: tips,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }
}

