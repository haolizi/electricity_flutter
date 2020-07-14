/*
 * -------分类页-------
 * 左侧大分类列表
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/request/service_method.dart';
import '../providers/category_provider.dart';
import '../providers/category_goods_provider.dart';
import '../models/category_model.dart';
import 'dart:convert';

class LeftCategoryListWidget extends StatefulWidget {
  LeftCategoryListWidget({Key key}) : super(key: key);

  @override
  _LeftCategoryListWidgetState createState() => _LeftCategoryListWidgetState();
}

class _LeftCategoryListWidgetState extends State<LeftCategoryListWidget> {
  List list = [];
  var listIndex = 0;
  @override
  void initState() {
    _getCatagoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
      ),
    );
  }

  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        // 点击大分类item，获取小分类列表，并请求商品列表数据
        var childCategoryList = list[index].bxMallSubDto;
        var categoryIdStr = list[index].mallCategoryId;
        Provider.of<ChildCategoryProvoder>(context, listen: false)
            .getChildCategory(childCategoryList, categoryIdStr);

        _getGoodsListData(categoryId: categoryIdStr);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        decoration: BoxDecoration(
            color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Center(
          child: Text(
            list[index].mallCategoryName,
            style: TextStyle(fontSize: ScreenUtil().setSp(30)),
          ),
        ),
      ),
    );
  }

  // 请求分类列表（大分类、小分类）
  void _getCatagoryData() async {
    await DioUtil.requestData('categoryUrl').then((value) {
      var data = json.decode(value.toString());
      CategoryModel listModel = CategoryModel.fromJson(data);
      setState(() {
        list = listModel.data;
      });
      Provider.of<ChildCategoryProvoder>(context, listen: false)
          .getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
      _getGoodsListData();
    });
  }

  // 请求商品列表
  void _getGoodsListData({String categoryId}) async {
    String categoryId =
        Provider.of<ChildCategoryProvoder>(context, listen: false).categoryId;
    Provider.of<CategoryGoodsListProvide>(context, listen: false)
        .getCategoryGoodsList(categoryId: categoryId, categodySubId: '');
  }
}
