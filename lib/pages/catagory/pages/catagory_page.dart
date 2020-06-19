/*
 * -------分类页首页-------
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:fluro/fluro.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/service_method.dart';
import '../models/category_model.dart';
import '../models/categody_goods_model.dart';
import '../providers/category_provider.dart';
import '../providers/category_goods_provider.dart';
import '../../../config/color.dart';
import '../../../config/routers/router_application.dart';

class CatagoryPage extends StatefulWidget {
  CatagoryPage({Key key}) : super(key: key);

  @override
  _CatagoryPageState createState() => new _CatagoryPageState();
}

class _CatagoryPageState extends State<CatagoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: <Widget>[
        LeftCategoryList(),
        Column(
          children: <Widget>[
            RightTopCategory(),
            CategoryGoodsList(),
          ],
        )
      ],
    ));
  }
}

// 左侧大类列表
class LeftCategoryList extends StatefulWidget {
  LeftCategoryList({Key key}) : super(key: key);

  @override
  _LeftCategoryListState createState() => _LeftCategoryListState();
}

class _LeftCategoryListState extends State<LeftCategoryList> {
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
          var childCategoryList = list[index].bxMallSubDto;
          var categoryIdStr = list[index].mallCategoryId;
          Provider.of<ChildCategoryProvoder>(context, listen: false).getChildCategory(childCategoryList, categoryIdStr);
          _getGoodsListData(categoryId:categoryIdStr); // 获取商品列表
        },
        child: Container(
          height: ScreenUtil().setHeight(100),
          decoration: BoxDecoration(
            color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
            border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
          child: Center(
            child: Text(
              list[index].mallCategoryName,
              style: TextStyle(fontSize: ScreenUtil().setSp(30)),
            ),
          ),
        ));
  }

  // 请求分类列表（大分类、小分类）
  void _getCatagoryData() async {
    await DioUtil.requestData('categoryUrl').then((value) {
      var data = json.decode(value.toString());
      CategoryModel listModel = CategoryModel.fromJson(data);
      setState(() {
        list = listModel.data;
      }); 
      Provider.of<ChildCategoryProvoder>(context, listen: false).getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
      _getGoodsListData();
    });
  }

  // 请求商品列表
  void _getGoodsListData({String categoryId}) async {
    var formData = {
      'page':"1",
      'categoryId':categoryId == null?'2c9f6c946cd22d7b016cd74220b70040':categoryId,
      'categodySubId':'',
    };
    await DioUtil.requestData('categoryGoodsListUrl', formData: formData).then((value) {
      var data = json.decode(value.toString());
      CategoryGoodsListModel goodsModel = CategoryGoodsListModel.fromJson(data);
      Provider.of<CategoryGoodsListProvide>(context, listen: false).getGoodsList(goodsModel.data);
    });
  }
}

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
        return  Container(
          width: ScreenUtil().setWidth(750 - 180),
          height: 40,
          decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context, index) {
              return _rightInkWell(childCategory.childCategoryList[index], index);
            },
          )
        );
      },
    );
  }

  Widget _rightInkWell(BxMallSubDto item, int index) {
    bool isClick = false;
    isClick = (index == Provider.of<ChildCategoryProvoder>(context, listen: false).childIndex) ? true : false;
    return InkWell(
      onTap: () {
        Provider.of<ChildCategoryProvoder>(context, listen: false).changeChildIndex(index);
        _getGoodsListData(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(7, 10, 7, 10),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: 14,
            color:isClick?Colors.red:Colors.black
          ),
        ),
      ),
    );
  }

  void _getGoodsListData(String categorySubId) async {
    var formData = {
      'page':"1",
      'categoryId':Provider.of<ChildCategoryProvoder>(context, listen: false).categoryId,
      'categodySubId':categorySubId,
    };

    await DioUtil.requestData('categoryGoodsListUrl', formData: formData).then((value) {
      var data = json.decode(value.toString());
      CategoryGoodsListModel goodsModel = CategoryGoodsListModel.fromJson(data);
      Provider.of<CategoryGoodsListProvide>(context, listen: false).getGoodsList(goodsModel.data);
    });
  }
}

// 商品列表
class CategoryGoodsList extends StatefulWidget {
  CategoryGoodsList({Key key}) : super(key: key);

  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    // double screenHg = MediaQuery.of(context).size.height;
    return Consumer<CategoryGoodsListProvide>(
      builder: (BuildContext context, goodsData, child) {
        return Expanded(
          child: Container(
            width: ScreenUtil().setWidth(570),
            child: ListView.builder(
              itemCount: goodsData.goodsList.length,
              itemBuilder: (context, index) {
                return _listItem(goodsData.goodsList, index);
              }
            ),
          ),
        );
      },
    );
  }

  Widget _listItem(List goodsList, int index) {
    return InkWell(
      onTap: (){
        ApplicationRouter.router.navigateTo(context, 'detail?id=${goodsList[index].goodsId}', transition:TransitionType.native);
      },
      child: Container(
        padding: EdgeInsets.only(top:5.0, bottom:5.0),
        decoration: BoxDecoration(
          color:Colors.white,
          border:Border(
            bottom: BorderSide(width:1.0, color:Colors.black12)
          )
        ),
        child: Row(
        children: <Widget>[
          _goodsImage(goodsList, index),
          Column(
            children: <Widget>[
              _goodsName(goodsList, index),
              _goodsPrice(goodsList, index),
            ],
          ),
        ],
      ),
      ),
    );
  }

  Widget _goodsImage(List goodsList, index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(goodsList[index].image),
    );
  }

  Widget _goodsName(List goodsList, index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        goodsList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize:14),
      ),
    );
  }

  Widget _goodsPrice(List goodsList, index) {
    return Container(
      margin: EdgeInsets.only(top:20.0),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Text(
            '价格：￥${goodsList[index].presentPrice}',
            style: TextStyle(
              fontSize:15,
              color: KColor.themeColor
            ),
          ),
          Text(
            '￥${goodsList[index].oriPrice}',
            style: TextStyle(
              fontSize:12,
              color:Colors.black26,
              decoration: TextDecoration.lineThrough
            ),
          ),
        ],
      ),
    );
  }
}