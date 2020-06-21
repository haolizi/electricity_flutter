/*
 * -------首页-------
 * 楼层小模块
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluro/fluro.dart';
import 'home_adbanner_widget.dart';
import '../../../config/routers/router_application.dart';

class FloorItem extends StatelessWidget {
  final String topImage;
  final List floorGoodsList;
  const FloorItem({Key key, this.topImage, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Column(
        children: <Widget>[
          AdBanner(imageUrl: topImage),
          _firstRow(context),
          _otherGoods(context)
        ],
      ),
    );
  }

  // 第一排是左边一张大图，右边两张小图
  Widget _firstRow(context) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Row(
        children: <Widget>[
          _goodsItem(context, floorGoodsList[0]),
          Column(
            children: <Widget>[
              _goodsItem(context, floorGoodsList[1]),
              _goodsItem(context, floorGoodsList[2])
            ],
          ),
        ],
      ),
    );
  }

  // 第二排是左右各一张小图
  Widget _otherGoods(context) {
    return Row(
      children: <Widget>[
        _goodsItem(context, floorGoodsList[3]),
        _goodsItem(context, floorGoodsList[4])
      ],
    );
  }

  // 商品item
  Widget _goodsItem(context, Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {
          ApplicationRouter.router.navigateTo(context, 'detail?id=${goods['goodsId']}', transition: TransitionType.native);
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}