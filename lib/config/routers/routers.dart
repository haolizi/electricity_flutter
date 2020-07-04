import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'router_handler.dart';

class Routes {
  static String root = '/';                             // 根目录
  static String detailPage = '/detail';                 // 详情页面
  static String orderPayPage = '/order/pay';            // 订单详情页面
  static String orderAdressPage = '/order/adress';      // 订单选择地址页面
  static String orderAddAdressPage = '/order/addAdress';// 订单添加地址页面

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return Text('未找到页面');
      }
    );

    // 创建pageRoute
    router.define(detailPage, handler: homeDetailsHandler);
    router.define(orderPayPage, handler: orderPayHandler);
    router.define(orderAdressPage, handler: orderAdressHandler);
    router.define(orderAddAdressPage, handler: orderAddAdressHandler);
  }
}
