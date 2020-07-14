import 'package:flutter/material.dart';
import '../models/categody_goods_model.dart';
import '../../../config/request/service_method.dart';
import 'dart:convert';

// 分类商品列表
class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryListData> goodsList = [];

  getCategoryGoodsList({String categoryId, String categodySubId}) async {
    var formData = {
      'page': "1",
      'categoryId':
          categoryId == null ? '2c9f6c946cd22d7b016cd74220b70040' : categoryId,
      'categodySubId': categodySubId == null ? '' : categodySubId
    };

    await DioUtil.requestData('categoryGoodsListUrl', formData: formData)
        .then((value) {
      var data = json.decode(value.toString());
      CategoryGoodsListModel goodsModel = CategoryGoodsListModel.fromJson(data);
      goodsList = goodsModel.data;

      notifyListeners();
    });
  }
}
