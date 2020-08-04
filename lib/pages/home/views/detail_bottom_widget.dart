/*
 * -------详情页-------
 * 底部操作按钮
 */

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_01/config/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../cart/providers/cart_provider.dart';
import '../providers/detail_provider.dart';
import 'package:toast/toast.dart';
import '../../../config/routers/tab_index_provider.dart';
import '../../../config/routers/router_application.dart';

class DetailBottomWidget extends StatelessWidget {
  const DetailBottomWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var goodsInfo = Provider.of<DetailInfoProvider>(context, listen: false)
        .detailModel
        .data
        .goodInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var price = goodsInfo.presentPrice;
    var image = goodsInfo.image1;
    int goodsCount;

    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      height: ScreenUtil().setHeight(90),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              // 购物车
              InkWell(
                onTap: () {
                  Provider.of<CurrentIndexProvider>(context, listen: false)
                      .changeTabIndex(2);
                  Navigator.pop(context);
                },
                child: Container(
                  width: ScreenUtil().setWidth(110),
                  alignment: Alignment.center,
                  child: Icon(Icons.shopping_cart,
                      size: 30, color: KColor.themeColor),
                ),
              ),

              Consumer<CartProvider>(
                  builder: (BuildContext context, value, child) {
                goodsCount = value.allGoodsCount;
                return goodsCount > 0
                    ? Positioned(
                        top: 0,
                        right: 5,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                          decoration: BoxDecoration(
                              color: KColor.themeColor,
                              border: Border.all(width: 2, color: Colors.white),
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Text(
                            '${goodsCount}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(22)),
                          ),
                        ),
                      )
                    : Text('');
              })
            ],
          ),

          // 加入购物车
          InkWell(
            onTap: () async {
              await Provider.of<CartProvider>(context, listen: false)
                  .addGoodsToCart(goodsId, goodsName, count, price, image);
              Toast.show("添加成功", context,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
            },
            child: Container(
              width: ScreenUtil().setWidth(320),
              alignment: Alignment.center,
              color: Colors.green,
              child: Text('加入购物车',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),

          // 立即购买
          InkWell(
            onTap: () async {
              if (goodsCount > 0) {
                ApplicationRouter.router.navigateTo(context, 'order/pay',
                    transition: TransitionType.native);
              }
            },
            child: Container(
              color: Colors.red,
              width: ScreenUtil().setWidth(320),
              alignment: Alignment.center,
              child: Text('立即购买',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
