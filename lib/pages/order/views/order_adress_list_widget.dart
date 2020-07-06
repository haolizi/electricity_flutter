/*
 * -------订单支付选择地址页-------
 * 地址列表
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../models/order_adress_model.dart';
import '../providers/order_address_provider.dart';
import 'order_no_adress_widget.dart';

class AdressListWidget extends StatelessWidget {
  const AdressListWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderAdressProvider>(
        builder: (BuildContext context, child, value) {
      List<AdressInfoModel> adressList =
          Provider.of<OrderAdressProvider>(context, listen: false).infoList;
      if (adressList.length > 0) {
        return ListView.builder(
            itemCount: adressList.length,
            itemBuilder: (context, index) {
              return _listItemWidget(context, adressList[index], index);
            });
      } else {
        return NoAdressWidget();
      }
    });
  }

  Widget _listItemWidget(
      BuildContext context, AdressInfoModel model, int index) {
    return InkWell(
      onTap: () {
        Provider.of<OrderAdressProvider>(context, listen: false)
            .selectAdressInfo(model);
        Navigator.pop(context);
      },
      child: Container(
        width: ScreenUtil().setWidth(750),
        color: Colors.white,
        margin: EdgeInsets.only(top: 2),
        padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
        child: Row(
          children: <Widget>[
            _infoWidget(model),

            // 删除按钮
            Container(
              alignment: Alignment.centerRight,
              width: ScreenUtil().setWidth(95),
              decoration: BoxDecoration(
                  border: Border(
                left: BorderSide(width: 1, color: Colors.black12),
              )),
              child: IconButton(
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.black26,
                ),
                onPressed: () {
                  Provider.of<OrderAdressProvider>(context, listen: false)
                      .deleteOneAdress(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoWidget(AdressInfoModel model) {
    return Container(
      width: ScreenUtil().setWidth(630),
      child: Column(
        children: <Widget>[
          // 姓名、手机号
          Row(
            children: <Widget>[
              Text(
                model.name,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 10),
              Text(
                model.contact,
                style: TextStyle(fontSize: 12, color: Colors.black45),
              ),
            ],
          ),

          // 联系人地址
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text(model.adress + model.fullAdress),
          ),
        ],
      ),
    );
  }
}
