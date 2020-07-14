/*
 * -------订单支付页-------
 * 备注
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class RemarkWidget extends StatelessWidget {
  const RemarkWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              '备注：',
              style: TextStyle(color: Colors.black54),
            ),
          ),

          // 备注输入框
          Expanded(
            child: TextField(
              maxLines: 2,
              decoration: InputDecoration(
                hintText: '如服装类可以写明尺寸、型号、颜色等',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
