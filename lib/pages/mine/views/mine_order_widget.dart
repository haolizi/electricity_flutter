/*
 * -------我的-------
 * 我的订单
 */

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdeInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width:1, color:Colors.black12)
        ),
      ),
      child: ListTile(
        leading: Image.asset('images/mine/mine_order_list.png'),
        title: Text(
          '我的订单',
          style: TextStyle(fontSize: ScreenUtil().setSp(29)
        ),
        ),
        trailing: Image.asset('images/mine/right_arrow.png'),
      ),
    );
  }
}