/*
 * -------订单支付页-------
 * 底部结算
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import '../../cart/providers/cart_provider.dart';
import '../../../config/color.dart';
import 'package:toast/toast.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double allPrice =
        Provider.of<CartProvider>(context, listen: false).allPrice;
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(100),
      color: KColor.bgColor,
      child: Stack(
        children: <Widget>[
          Align(
            child: Row(
              children: <Widget>[
                Text('合计：'),
                Text(
                  '￥${allPrice.toStringAsFixed(2)}',
                  style: TextStyle(color: KColor.themeColor),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(130),
              height: ScreenUtil().setHeight(70),
              decoration: BoxDecoration(
                color: KColor.themeColor,
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: InkWell(
                onTap: () async {
                  int type = await _showModalBottomSheet(context);
                  print('-------type"${type}');
                },
                child: Text(
                  '去付款',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 底部弹出菜单
  Future<int> _showModalBottomSheet(BuildContext context) {
    return showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: ScreenUtil().setHeight(320),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Toast.show("微信支付", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.CENTER);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 25),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 30),
                        child: Image.asset('images/order/WX.png'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Toast.show("QQ支付", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.CENTER);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 25),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 30),
                        child: Image.asset('images/order/QQ.png'),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 25),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
