/*
 * -------详情页-------
 * 底部操作按钮
 */

import 'package:flutter/material.dart';
import 'package:flutter_01/config/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../cart/providers/cart_provider.dart';
import '../providers/detail_provider.dart';

class DetailBottom extends StatelessWidget {
  const DetailBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var goodsInfo = Provider.of<DetailInfoProvider>(context, listen: false).detailModel.data.goodInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var price = goodsInfo.presentPrice;
    var image = goodsInfo.image1;

    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      height: ScreenUtil().setHeight(80),
      child: Row(
        children: <Widget>[
          // 购物车
          InkWell(
            onTap: (){

            },
            child: Container(
              width: ScreenUtil().setWidth(110),
              alignment: Alignment.center,
              child: Icon(
                Icons.shopping_cart,
                size:30,
                color:KColor.themeColor
              ),
            ),
          ),

          // 加入购物车
          InkWell(
            onTap: () async{
              await Provider.of<CartProvider>(context, listen: false).addGoodsToCart(goodsId, goodsName, count, price, image);
            },
            child: Container(
              width: ScreenUtil().setWidth(320),
              alignment: Alignment.center,
              color: Colors.green,
              child: Text(
                '加入购物车',
                style:TextStyle(
                  fontSize:16,
                  color:Colors.white
                )
              ),
            ),
          ),

          // 立即购买
          InkWell(
            onTap: () async {
              // await Provider.of<CartProvider>(context, listen: false).removeAllGoods();
            },
            child: Container(
              color: Colors.red,
              width: ScreenUtil().setWidth(320),
              alignment: Alignment.center,
              child: Text(
                '立即购买',
                style:TextStyle(
                  fontSize:16,
                  color:Colors.white
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}