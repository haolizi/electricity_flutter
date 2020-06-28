/*
 * -------订单支付页-------
 * 底部结算
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import '../../cart/providers/cart_provider.dart';
import '../../../config/color.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double allPrice = Provider.of<CartProvider>(context, listen: false).allPrice;
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(100),
      color: Colors.grey[200],
      child: Row(
        children: <Widget>[
          Text('合计：'),
          Container(
            width: ScreenUtil().setWidth(525),
            child: Text(
              '￥${allPrice.toStringAsFixed(2)}',
              style: TextStyle(
                color: KColor.themeColor
              ),
            ),
          ),
          InkWell(
            onTap: (){

            },
            child: Container(
              width: ScreenUtil().setWidth(110),
              height: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: KColor.themeColor,
                border:Border.all(width: 1, color:Colors.white),
                borderRadius: BorderRadius.circular(4.0)
              ),
              child: Text(
                '去付款',
                style: TextStyle(
                  color:Colors.white,
                ),  
              ),
            ),
          )
        ],
      ),
    );
  }
}