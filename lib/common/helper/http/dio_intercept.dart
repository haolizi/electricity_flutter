import 'package:dio/dio.dart';
import '../../utils/global.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    /// 将token添加到请求头
    // if (Global.isLogin()) {
    //   // 未登录
    //   options.headers['Authorization'] = "Bearer " + Global.loginInfo.accessToken.toString();
    // }
    super.onRequest(options, handler);
  }
}

class LogInterceptor extends Interceptor {
  late DateTime _startTime;
  late DateTime _endTime;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _startTime = DateTime.now();
    // 此处根据业务逻辑，自行增加 requestUrl requestMethod headers queryParameters 等参数的打印

    String requestStr = "---request start---\nurl:${options.baseUrl + options.path}\nheaders:${options.headers}\nparams:${options.data}";
    Global.logger.i(requestStr);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _endTime = DateTime.now();
    final int duration = _endTime.difference(_startTime).inMilliseconds;
    String resultStr = "请求耗时：$duration ms\nresponse:${response.data}\n---request end---";
    Global.logger.i(resultStr);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Global.logger.e("---request error: ${err.toString()}");
    super.onError(err, handler);
  }
}
