/*
 * -------订单支付页-------
 * 定位
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PositionWidget extends StatelessWidget {
  const PositionWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: ScreenUtil().setWidth(750),
        height: 55,
        decoration: BoxDecoration(
          border: Border(
            top:BorderSide(width: 1,color:Colors.green),
            bottom:BorderSide(width: 1,color:Colors.green),
          )
        ),
        child: ListTile(
          leading: Icon(Icons.location_on),
          title: Text(
            '',
            style: TextStyle(
              fontSize: 16
            ),
          ),
          trailing: Image.asset('images/mine/right_arrow.png'),
        ),
      ),
    );
  }
}