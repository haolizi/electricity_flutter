import 'dart:convert';
import 'package:dio/dio.dart';
import 'base_error_code.dart';
import 'base_response.dart';

class DioWrapper {
  static BaseResponse errorWrapper(Object e) {
    BaseResponse errResult = e is DioError
        ? _dioErrorWrapper(e)
        : BaseResponse(code: HttpErrorCode.networkErrorCode, message: "");
    return BaseResponse(
      code: errResult.code,
      message: errResult.message,
      data: '',
      success: false,
      res: null,
    );
  }

  static BaseResponse _dioErrorWrapper(DioError error) {
    dynamic errorJson = {};
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        errorJson["code"] = HttpErrorCode.networkTimeoutCode;
        errorJson["msg"] = "网络超时";
        break;
      case DioErrorType.cancel:
        errorJson["code"] = HttpErrorCode.networkExceptionCode;
        errorJson["msg"] = "连接被取消";
        break;
      default:
        errorJson["code"] = HttpErrorCode.networkErrorCode;
        errorJson["msg"] = "网络错误";
        break;
    }

    return BaseResponse.fromJson(errorJson);
  }

  static BaseResponse responseWrapper(Response response) {
    // 此处如果数据比较大，可以使用 compute 放在后台计算
    final res = jsonDecode(response.data);
    if (response.statusCode == 200) {
      final BaseResponse wrapres = BaseResponse.fromJson(res);
      wrapres.res = response;
      return wrapres;
    } else {
      int code = -1;
      var msg = res["error_description"] ?? '';
      if (response.statusCode == 401) {
        code = HttpErrorCode.tokenExpireCode;
        msg = 'token失效';
      }
      return BaseResponse(
        code: code,
        success: false,
        message: msg,
        data: "",
        res: response,
      );
    }
  }
}
