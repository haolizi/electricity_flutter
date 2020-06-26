/*
 * -------订单支付页-------
 * 配送类型
 */
import 'package:flutter/material.dart';

class DistribType extends StatelessWidget {
  const DistribType({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.all(15),
      child: Row(
        children: <Widget>[
          Text(
            '配送类型：',
            style: TextStyle(
              color: Colors.black45,
              fontSize: 14
            ),  
          ),

          // 标签
          Container(
            width: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.lightGreen[100],
              border: Border.all(width: 0.5, color: Colors.green),
            ),
            child: Text(
              '配送到家',
              style: TextStyle(
                color: Colors.green,
                fontSize: 15
              ),  
            ),
          ),
        ],
      ),
    );
  }


}