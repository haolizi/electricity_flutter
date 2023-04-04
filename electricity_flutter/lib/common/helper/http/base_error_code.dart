class HttpErrorCode {
  /// 网络错误
  static const networkErrorCode = -1;
  /// 网络超时
  static const networkTimeoutCode = -2;
  /// 网络返回数据格式化一次
  static const networkJsonExceptionCode = -3;
  /// 网络连接异常
  static const networkExceptionCode = -4;
  /// 没有权限（token过期）
  static const tokenExpireCode = 401;
}