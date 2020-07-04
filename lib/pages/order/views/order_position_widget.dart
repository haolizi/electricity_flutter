/*
 * -------订单支付页-------
 * 定位
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../config/routers/router_application.dart';
import '../providers/order_address_provider.dart';
import '../models/order_adress_model.dart';

class PositionWidget extends StatelessWidget {
  const PositionWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderAdressProvider>(
        builder: (BuildContext context, child, value) {
      AdressInfoModel model =
          Provider.of<OrderAdressProvider>(context).selectModel;
      return InkWell(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
          decoration: BoxDecoration(
              border: Border(
              top: BorderSide(width: 1, color: Colors.green),
              bottom: BorderSide(width: 1, color: Colors.green),
            ),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.location_on),
              _adressInfoWidget(model),
              Image.asset('images/mine/right_arrow.png'),
            ],
          ),
        ),
        onTap: () {
          ApplicationRouter.router.navigateTo(context, 'order/adress',
              transition: TransitionType.native);
        },
      );
    });
  }

  Widget _adressInfoWidget(AdressInfoModel model) {
    return Container(
      width: ScreenUtil().setWidth(620),
      margin: EdgeInsets.only(left: 5),
      child: model == null?
      Text(
        '请选择您的位置',
        style: TextStyle(fontSize: 15, color: Colors.black87),
      ):
      Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                model.name,
                style: TextStyle(
                  fontSize: 14
                ),
              ),

              SizedBox(width: 5),

              Text(
                model.contact,
                style: TextStyle(
                  fontSize: 12
                ),
              ),
            ],
          ),

          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 5),
            child: Text(
              model.adress + model.fullAdress,
              style: TextStyle(
                fontSize: 13
              ),
            ),
          ),
          
        ],
      )
    );
  }
}
