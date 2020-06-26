/*
 * -------订单支付页-------
 */

import 'package:flutter/material.dart';
import '../views/order_distribution_type_widget.dart';
import '../views/order_position_widget.dart';
import '../views/order_goods_list_widget.dart';
import '../views/order_remark_widget.dart';
import '../views/order_price_list_widget.dart';
import '../views/order_bottom_widget.dart';

class OrderPayPage extends StatelessWidget {
  const OrderPayPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('订单确认')
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: ListView(
              children: <Widget>[
                DistribType(),     // 配送类型
                PositionWidget(),  // 定位
                GoodsListWidget(), // 商品列表
                RemarkWidget(),    // 备注
                PriceListWidget(), // 金额相关
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: BottomWidget()
          )
        ],
      ),
    );
  }
}
