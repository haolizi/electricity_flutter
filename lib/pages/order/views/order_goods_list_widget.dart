/*
 * -------订单支付页-------
 * 商品列表
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../cart/providers/cart_provider.dart';
import '../../cart/models/cart_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoodsListWidget extends StatelessWidget {
  const GoodsListWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CartInfoModel> cartList = Provider.of<CartProvider>(context, listen: false).infoList;
    double listCount = cartList.length.toDouble();
    return Container(
      height: listCount *71,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cartList.length,
        itemBuilder: (context, index) {
          return _goodItem(cartList[index]);
        },
      ),
    );
  }

  Widget _goodItem(CartInfoModel model) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border:Border(
          bottom:BorderSide(width:1, color:Colors.black12),
        ),
      ),
      child:Row(
        children: <Widget>[
          _goodImage(model.image),
          _goodName(model.goodsName), // 商品名称
          _goodPrice(model.price, model.count),
        ],
      ),
    );
  }

  Widget _goodImage(String url) {
    return Container(
      width: 60,
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border:Border.all(width:1, color: Colors.black12),
      ),
      child: Image.network(url),
    );
  }

  Widget _goodName(String name) {
    return Container(
      height: 60,
      width: ScreenUtil().setWidth(500),
      padding: EdgeInsets.fromLTRB(7, 5, 7, 0),
      alignment: Alignment.topLeft,
      child: Text(
        name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(24),
        ),
      ),
    );
  }

  Widget _goodPrice(double price, int count) {
    return Column(
      children: <Widget>[
        // 单价
        Text(
          '￥ ${price.toString()}',
          style: TextStyle(
            color: Colors.black54,
            fontSize: ScreenUtil().setSp(22),
          ),
        ),

        SizedBox(height:10),
        
        // 数量
        Text(
          'x${count.toString()}',
          style: TextStyle(
            color: Colors.black54,
            fontSize: ScreenUtil().setSp(22),
          ),
        ),
      ],
    );
  }  
}