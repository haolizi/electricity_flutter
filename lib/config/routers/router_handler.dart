import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../../pages/home/pages/home_detail_page.dart';
import '../../pages/order/pages/order_pay_page.dart';
import '../../pages/order/pages/order_adress_page.dart';
import '../../pages/order/pages/order_add_adress_page.dart';

// 商品详情
Handler homeDetailsHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  String goodsId = params['id'].first;
  return HomeDetailPage(goodsId: goodsId);
});

// 订单支付
Handler orderPayHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return OrderPayPage();
});

// 订单选择地址
Handler orderAdressHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return OrderAdressPage();
});

// 订单添加地址
Handler orderAddAdressHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return OrderAddAdressPage();
});