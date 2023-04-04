
class Config {
  /// 域名
  static const String baseUrl = "https://wxmini.baixingliangfan.cn/";

  /// http连接超时时间
  static const int connectTimeout = 30 * 1000;
  /// http响应超时时间
  static const int receiveTimeout = 60 * 1000;
  /// 每页请求数据
  static const int pageSize = 10;
}