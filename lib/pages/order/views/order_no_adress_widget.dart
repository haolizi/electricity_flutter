/*
 * -------订单支付选择地址页-------
 * 无数据页
 */

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../../../config/color.dart';
import '../../../config/routers/router_application.dart';

class NoAdressWidget extends StatelessWidget {
  const NoAdressWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 120,
        height: 155,
        child: Column(
          children: <Widget>[
            Icon(
              Icons.note_add,
              color: Colors.black12,
              size: 70,
            ),
            _noteWidget(),
            _addBtnWidget(context)
          ],
        ),
      ),
    );
  }

  Widget _noteWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 6, 0, 10),
      child: Text(
        '您还未添加地址~',
        style: TextStyle(color: Colors.black45),
      ),
    );
  }

  Widget _addBtnWidget(BuildContext context) {
    return FlatButton(
        color: KColor.themeColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: Text(
          '点击添加',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          ApplicationRouter.router.navigateTo(context, 'order/addAdress',
              transition: TransitionType.native);
        });
  }
}
