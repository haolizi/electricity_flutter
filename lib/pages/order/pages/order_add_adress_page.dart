/*
 * -------订单支付页-------
 * 添加地址
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toast/toast.dart';
import '../../../config/color.dart';
import '../providers/order_address_provider.dart';
import 'package:provider/provider.dart';

class OrderAddAdressPage extends StatelessWidget {
  final List normalList = [
    {'title': '姓名：', 'placehold': '请输入收货人姓名', 'text': ''},
    {'title': '电话：', 'placehold': '请输入电话号码', 'text': ''},
    {'title': '地区：', 'placehold': '请输入省市区信息', 'text': ''},
    {'title': '详细地址：', 'placehold': '请输入详细地址', 'text': ''}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加位置'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 4),
            child: ListView.builder(
              itemCount: normalList.length,
              itemBuilder: (context, index) {
                return _rowWidget(normalList[index], index);
              },
            ),
          ),

          // 添加按钮
          Positioned(bottom: 0, left: 0, child: _addWidget(context)),
        ],
      ),
    );
  }

  // 列表item
  Widget _rowWidget(item, index) {
    return Container(
      margin: EdgeInsets.only(top: 2),
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Text(item['title']),
          SizedBox(width: 5),
          Container(
            width: ScreenUtil().setWidth(750) - 100,
            child: TextField(
              decoration: InputDecoration(
                hintText: item['placehold'],
                border: InputBorder.none,
              ),
              keyboardType:
                  index == 1 ? TextInputType.number : TextInputType.text,
              onChanged: (value) {
                normalList[index]['text'] = value;
                print('--------normalList:${normalList}');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _addWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        bool isInputAll = true;
        normalList.forEach((element) {
          String textStr = element['text'];
          if (textStr.length <= 0) {
            isInputAll = false;
            Toast.show("请将信息填写完整", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
            return;
          }
        });

        // 全部输入
        if (isInputAll) {
          String name = normalList[0]['text'];
          String contact = normalList[1]['text'];
          String adress = normalList[2]['text'];
          String fullAdress = normalList[0]['text'];
          Provider.of<OrderAdressProvider>(context, listen: false)
              .addAdressToList(name, contact, adress, fullAdress);
          Navigator.pop(context);
        }
      },
      child: Container(
        width: ScreenUtil().setWidth(750),
        height: ScreenUtil().setHeight(90),
        alignment: Alignment.center,
        color: KColor.themeColor,
        child: Text(
          '添加',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
