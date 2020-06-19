/*
 * -------tabbar状态管理-------
 */

import 'package:flutter/material.dart';

class CurrentIndexProvider with ChangeNotifier {
  int currentIndex = 0;// 默认首页
  changeTabIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}