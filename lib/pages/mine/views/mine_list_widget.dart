/*
 * -------我的-------
 * 下面列表
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListTitleWidget extends StatelessWidget {
  final String title;
  final String icon;
  const ListTitleWidget({Key key, this.title, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
            _listItem('领取优惠券', 'images/mine/mine_coupons.png'),
            _listItem('已领取优惠券', 'images/mine/mine_coupons.png'),
            _listItem('地址管理', 'images/mine/mine_position.png'),
            _listItem('客服电话', 'images/mine/mine_service.png'),
            _listItem('关于我们', 'images/mine/mine_about.png'),
        ],
      ),
    );
  }

  Widget _listItem(String title, String icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom:BorderSide(width: 1,color:Colors.black12)
        )
      ),
      child: ListTile(
        leading: Image.asset(icon),
        title: Text(
          title,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(29)
          ),
        ),
        trailing: Image.asset('images/mine/right_arrow.png'),
      ),
    );
  }
}