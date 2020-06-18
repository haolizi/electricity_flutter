import 'package:flutter/material.dart';
import '../models/categody_goods_model.dart';

// 分类商品列表
class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryListData> goodsList = [];
  
  // 点击大类更换商品列表
  getGoodsList(List<CategoryListData> list) {
    goodsList = list;
    notifyListeners();
  }
}