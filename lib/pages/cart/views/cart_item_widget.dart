/*
 * -------购物车页面-------
 * 每个item
 */

import 'package:flutter/material.dart';
import 'package:flutter_01/pages/cart/models/cart_model.dart';
import '../../../config/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'car_item_calculate_widget.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  final CartInfoModel model;
  const CartItem(this.model);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border:Border(
          bottom:BorderSide(width:1, color:Colors.black12),
        ),
      ),
      child:Row(
        children: <Widget>[
          _checkBtn(context),
          _goodImage(),
          _goodName(), //商品名称和加减按钮
          _goodPrice(context),
        ],
      ),
    );
  }

  // 复选按钮
  Widget _checkBtn(context) {
    return Container(
      child: Checkbox(
        value: model.isCheck, 
        activeColor: KColor.themeColor,
        onChanged: (bool isCheck) {
          model.isCheck = isCheck;
          Provider.of<CartProvider>(context, listen: false).changeCheckState(model);
        }
      )
    );
  }

  // 商品图片
  Widget _goodImage() {
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border:Border.all(width:1, color: Colors.black12),
      ),
      child: Image.network(model.image),
    );
  }

  // 商品名称
  Widget _goodName() {
    return Container(
      width: ScreenUtil().setWidth(320),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(model.goodsName),
          CartCalculate(model), // 加减按钮
        ],
      ),
    );
  }

  // 商品价格
  Widget _goodPrice(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(140),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text(
            '￥${model.price}',
          ),

          // 删除按钮
          Container(
            margin: EdgeInsets.only(top:10),
            child: InkWell(
              onTap: () async {
                await Provider.of<CartProvider>(context, listen: false).deleteOneGood(model.goodsId);
              },
              child: Icon(
                Icons.delete_forever,
                color: Colors.black26,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}