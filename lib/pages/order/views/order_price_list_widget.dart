/*
 * -------订单支付页-------
 * 商品金额、运费、总支付金额
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../cart/providers/cart_provider.dart';

class PriceListWidget extends StatelessWidget {
  const PriceListWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double allPrice =
        Provider.of<CartProvider>(context, listen: false).allPrice;
    List list = [
      {'title': '商品金额', 'detail': allPrice.toStringAsFixed(2)},
      {'title': '运费', 'detail': '0.00'},
      {'title': '实付总额', 'detail': allPrice.toStringAsFixed(2)}
    ];
    return Container(
      height: 123,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ListView.builder(
        itemCount: list.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _item(list[index]['title'], list[index]['detail']);
        },
      ),
    );
  }

  Widget _item(String title, String price) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(width: ScreenUtil().setWidth(500), child: Text(title)),
          Container(
            alignment: Alignment.centerRight,
            width: ScreenUtil().setWidth(200),
            child: Text(price),
          )
        ],
      ),
    );
  }
}
