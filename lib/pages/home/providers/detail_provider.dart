/*
 * -------详情页-------
 * provider
 */

import 'package:flutter/material.dart';
import '../models/detail_model.dart';
import '../../../config/service_method.dart';
import 'dart:convert';

class DetailInfoProvider with ChangeNotifier {
  DetailModel detailModel;
  // tabbar
  bool isSelectLeft = true;
  bool isSelectRight = false;
  changeTabbar(String changeState) {
    if (changeState == 'left') {
      isSelectLeft = true;
      isSelectRight = false;
    } else {
      isSelectLeft = false;
      isSelectRight = true;
    }
    notifyListeners();
  } 

  // 获取详情信息 
  getGoodsInfo(String id) async {
    var formData = {'goodId':id};
    await DioUtil.requestData('detailGoodsUrl', formData: formData).then((value) {
      var data = json.decode(value.toString());
      detailModel = DetailModel.fromJson(data);
      notifyListeners();
    });
  } 
}
