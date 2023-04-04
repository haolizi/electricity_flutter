import 'package:electricity_flutter/common/page/base_text_style.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'color.dart';

class Global {
  static var logger;

  /// 初始化
  static Future init() async {
    Global.logger ??= Logger();
  }
}
