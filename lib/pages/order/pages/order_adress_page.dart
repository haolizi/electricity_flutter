/*
 * -------订单支付页-------
 * 选择地址
 */

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_address_provider.dart';
import '../views/order_no_adress_widget.dart';
import '../views/order_adress_list_widget.dart';
import '../../../config/routers/router_application.dart';

class OrderAdressPage extends StatelessWidget {
  const OrderAdressPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择位置'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              ApplicationRouter.router.navigateTo(context, 'order/addAdress', transition:TransitionType.native);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _getAdressInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AdressListWidget();
          } else {
            return NoAdressWidget();
          }
        }),
    );
  }

  Future _getAdressInfo(BuildContext context) async {
    await Provider.of<OrderAdressProvider>(context, listen: false)
        .getAdressList();
    return '加载完成';
  }

  // Widget _testWidget(BuildContext context) {
  //   return InkWell(
  //     onTap: () {
  //       Provider.of<OrderAdressProvider>(context, listen: false)
  //           .addAdressToList('帅呆酷毙', '13888888888', '深圳市南山区腾讯滨海大厦', '2020');
  //     },
  //     child: Text('11111'),
  //   );
  // }
}
