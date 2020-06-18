import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../../pages/home/pages/home_detail_page.dart';

Handler homeDetailsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    String goodsId = params['id'].first;
    return HomeDetailPage(goodsId:goodsId);
  }
);