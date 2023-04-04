import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ume/core/plugin_manager.dart';
import 'package:flutter_ume/core/ui/root_widget.dart';
import 'package:flutter_ume_kit_console/flutter_ume_kit_console.dart';
import 'package:flutter_ume_kit_device/components/cpu_info/cpu_info_page.dart';
import 'package:flutter_ume_kit_device/components/device_info/device_info_panel.dart';
import 'package:flutter_ume_kit_dio/flutter_ume_kit_dio.dart';
import 'package:flutter_ume_kit_perf/flutter_ume_kit_perf.dart';
import 'package:flutter_ume_kit_show_code/show_code/show_code.dart';
import 'package:flutter_ume_kit_ui/components/align_ruler/align_ruler.dart';
import 'package:flutter_ume_kit_ui/components/color_picker/color_picker.dart';
import 'package:flutter_ume_kit_ui/components/color_sucker/color_sucker.dart';
import 'package:flutter_ume_kit_ui/components/touch_indicator/touch_indicator.dart';
import 'package:flutter_ume_kit_ui/components/widget_detail_inspector/widget_detail_inspector.dart';
import 'package:flutter_ume_kit_ui/components/widget_info_inspector/widget_info_inspector.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import 'common/helper/http/dio_utils.dart';
import 'common/utils/global.dart';
import 'main/main_page.dart';
import 'pages/cart/logics/cart_logic.dart';

void main() {
  if (kDebugMode) {
    /// 调试工具
    PluginManager.instance
      ..register(const WidgetInfoInspector())
      ..register(const WidgetDetailInspector())
      ..register(const ColorSucker())
      ..register(AlignRuler())
      ..register(const ColorPicker())
      ..register(const TouchIndicator())
      ..register(Performance())
      ..register(const ShowCode())
      ..register(const MemoryInfoPage())
      ..register(CpuInfoPage())
      ..register(const DeviceInfoPanel())
      ..register(Console())
      ..register(DioInspector(dio: HttpUtils.instance.dio));
    // After flutter_ume 0.3.0
    runApp(const UMEWidget(child: MyApp(), enable: true));
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    lockScreen();
    Global.init();

    Get.put(CartLogic());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          builder: (BuildContext context, Widget? child) {
            /// 不跟随系统字体变大变小
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
          enableLog: true,
          transitionDuration: const Duration(milliseconds: 200),
          defaultTransition: Transition.rightToLeft,
          themeMode: ThemeMode.system,
          title: '某知名电商',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(),
        );
      },
    );
  }

  lockScreen() {
    /// 锁定屏幕方向
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    if (Platform.isAndroid) {
      SystemUiOverlayStyle style =
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(style);
    }
  }
}
