import 'package:flutter/material.dart';
import '../models/category_model.dart';

// 二级分类
class ChildCategoryProvoder with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  String categoryId = '2c9f6c946cd22d7b016cd74220b70040'; // 大分类id默认值
  int childIndex = 0;

  // 根据大分类item获取小分类列表数据
  getChildCategory(List<BxMallSubDto> list, String id) {
    categoryId = id;

    // 在第一项添加全部默认数据
    BxMallSubDto firstIndex = BxMallSubDto();
    firstIndex.mallSubId = '00';
    firstIndex.mallCategoryId = '00';
    firstIndex.comments = 'null';
    firstIndex.mallSubName = '全部';
    childCategoryList = [firstIndex];

    childCategoryList.addAll(list);
    notifyListeners();
  }

  // 改变子类索引
  changeChildIndex(index) {
    childIndex = index;
    notifyListeners();
  }
}
