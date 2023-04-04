import 'package:flutter_screenutil/flutter_screenutil.dart';

/*
 * 建议使用：
 * 100.w 代替ScreenUtil().setWidth(100)
 * 100.h 代替ScreenUtil().setHeight(100)
*/

/// 设置宽度
double screenSetWidth(double width) {
  return ScreenUtil().setWidth(width);
}

/// 设置高度
double screenSetHeight(double height) {
  return ScreenUtil().setHeight(height);
}

/// 设置字体尺寸
double screenSetFontSize(double fontSize) {
  return ScreenUtil().setSp(fontSize);
}

/// 获取屏幕宽度
double screenGetWidth() {
  return ScreenUtil().screenWidth;
}

/// 导航栏高度 （状态栏+appbar）
double getNavBarHeight() {
  return ScreenUtil().statusBarHeight + 44.0;
}

/// 获取状态栏高度（包括刘海）
double getStatusBarHeight() {
  return ScreenUtil().statusBarHeight;
}

/// 获取底部安全高度
double getBottomBarHeight() {
  return ScreenUtil().bottomBarHeight;
}
