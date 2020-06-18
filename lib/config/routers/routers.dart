import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'router_handler.dart';

class Routes {
  static String root = '/';
  static String detailPage = '/detail';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return Text('未找到页面');
      }
    );

    router.define(detailPage, handler: homeDetailsHandler);
  }
}
