/*
 * -------分类页-------
 * 右顶部小分类列表
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/category_provider.dart';
import '../providers/category_goods_provider.dart';
import '../models/category_model.dart';

// 右侧顶部分类
class RightTopCategory extends StatefulWidget {
  RightTopCategory({Key key}) : super(key: key);

  @override
  _RightTopCategoryState createState() => _RightTopCategoryState();
}

class _RightTopCategoryState extends State<RightTopCategory> {
  List list = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<ChildCategoryProvoder>(
      builder: (BuildContext context, childCategory, child) {
        return Container(
          width: ScreenUtil().setWidth(570),
          height: 40,
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 1, color: Colors.black12))),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context, index) {
              return _rightInkWell(
                  childCategory.childCategoryList[index], index);
            },
          ),
        );
      },
    );
  }

  Widget _rightInkWell(BxMallSubDto item, int index) {
    bool isClick = false;
    isClick = (index ==
            Provider.of<ChildCategoryProvoder>(context, listen: false)
                .childIndex)
        ? true
        : false;
    return InkWell(
      onTap: () {
        Provider.of<ChildCategoryProvoder>(context, listen: false)
            .changeChildIndex(index);
        _getGoodsListData(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(7, 10, 7, 10),
        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: 14, color: isClick ? Colors.red : Colors.black),
        ),
      ),
    );
  }

  // 获取商品列表
  void _getGoodsListData(String categorySubId) async {
    String categoryId =
        Provider.of<ChildCategoryProvoder>(context, listen: false).categoryId;
    Provider.of<CategoryGoodsListProvide>(context, listen: false)
        .getCategoryGoodsList(
            categoryId: categoryId, categodySubId: categorySubId);
  }
}
