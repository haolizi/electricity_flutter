/*
 * -------分类页首页-------
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/category_goods_provider.dart';
import '../../../config/color.dart';
import '../../../config/routers/router_application.dart';
import '../views/left_list_widget.dart';
import '../views/right_top_widget.dart';

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
          LeftCategoryListWidget(), // 左边大分类列表
          Column(
            children: <Widget>[
              RightTopCategory(), // 右顶部小分类列表
              CategoryGoodsList(), // 商品列表
            ],
          ),
        ],
      ),
    );
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
    return Consumer<CategoryGoodsListProvide>(
      builder: (BuildContext context, goodsData, child) {
        return Expanded(
          child: Container(
            width: ScreenUtil().setWidth(570),
            child: ListView.builder(
                itemCount: goodsData.goodsList.length,
                itemBuilder: (context, index) {
                  return _listItem(goodsData.goodsList, index);
                }),
          ),
        );
      },
    );
  }

  Widget _listItem(List goodsList, int index) {
    return InkWell(
      onTap: () {
        ApplicationRouter.router.navigateTo(
            context, 'detail?id=${goodsList[index].goodsId}',
            transition: TransitionType.native);
      },
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1.0, color: Colors.black12))),
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
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _goodsPrice(List goodsList, index) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Text(
            '价格：￥${goodsList[index].presentPrice}',
            style: TextStyle(fontSize: 15, color: KColor.themeColor),
          ),
          Text(
            '￥${goodsList[index].oriPrice}',
            style: TextStyle(
                fontSize: 12,
                color: Colors.black26,
                decoration: TextDecoration.lineThrough),
          ),
        ],
      ),
    );
  }
}
