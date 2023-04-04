import 'dart:ffi';

import 'package:dio/dio.dart';

class BaseResponse {
  // 通用参数
  late int code = -1;
  late String message;
  dynamic data;

  // 业务请求是否成功
  late bool success;

  // Dio 返回的原始 Response 数据
  Response? res;

  BaseResponse({
    required this.code,
    required this.message,
    this.data,
    this.success = true,
    this.res,
  });

  BaseResponse.fromJson(dynamic json) {
    if (json['code'] != null) {
      var codeVar = json['code'];
      String codeStr = "$codeVar";
      code = int.parse(codeStr);
    }
    message = json?['message'] ?? '';
    data = json?['data'] ?? '';
    success = code == 0 ? true : false;
  }
}
