/*
 * -------购物车页面-------
 * item中的加减按钮
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/cart_model.dart';

class CartCalculate extends StatelessWidget {
  final CartInfoModel model;
  CartCalculate(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top:6.0),
      decoration: BoxDecoration(
        border: Border.all(
          width:1.0, 
          color:Colors.black12
        )
      ),
      child: Row(
        children: <Widget>[
          _reduceBtn(context),
          _numArea(context),
          _addBtn(context)
        ],
      ),
    );
  }

  // 减少按钮
  Widget _reduceBtn(context) {
    return InkWell(
      onTap: () {
        Provider.of<CartProvider>(context, listen: false).addOrReduceAction(model, 'reduce');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:model.count > 1?Colors.white:Colors.black12,
          border: Border(
            right: BorderSide(width:1.0, color:Colors.black12)
          ),
        ),
        child: Text('-'),
      ),
    );
  }

  // 商品数量
  Widget _numArea(context) {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${model.count}'),
    );
  }

  // 加号按钮
  Widget _addBtn(context) {
    return InkWell(
      onTap: () {
        Provider.of<CartProvider>(context, listen: false).addOrReduceAction(model, 'add');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:Colors.white,
          border: Border(
            left: BorderSide(width:1.0, color:Colors.black12)
          ),
        ),
        child: Text('+'),
      ),
    );
  }
}