/*
 * -------我的-------
 * 订单四个状态
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderStatus extends StatelessWidget {
  final List itemList = [
    {'icon':'images/mine/wait_pay.png', 'title':'待付款'},
    {'icon':'images/mine/wait_delivery.png', 'title':'待发货'},
    {'icon':'images/mine/wait_harvest.png', 'title':'待收获'},
    {'icon':'images/mine/wait_evaluate.png', 'title':'待评价'}
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: 155/2,
      padding: EdgeInsets.only(top:10),
      color: Colors.white,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        padding: EdgeInsets.all(5.0),
        children: itemList.map((item) {
          return _categoryItem(context, item);
        }).toList(),
      ),
    );
  }

  Widget _categoryItem(BuildContext context, item) {
    return InkWell(
      onTap: () {
        
      },
      child: Column(
        children: <Widget>[
          Image.asset(item['icon']),
          SizedBox(height:5),
          Text(
            item['title'],
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}