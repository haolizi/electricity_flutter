/*
 * -------我的-------
 * 头部图片和头像
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopHead extends StatelessWidget {
  const TopHead({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color:Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          // 头像
          Container(
            margin: EdgeInsets.only(top:30),
            child: ClipOval(
              child: Image.asset('images/mine/avatar_placehold_gray.png'),
            ),
          ),

          Container(
            width: ScreenUtil().setWidth(160),
            height: ScreenUtil().setHeight(60),
            margin: EdgeInsets.only(top:14),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border:Border.all(width: 1, color:Colors.white),
              borderRadius: BorderRadius.circular(4.0)
            ),
            child: Text(
              '点击登录',
              style: TextStyle(
                fontSize:ScreenUtil().setSp(30),
                color:Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}