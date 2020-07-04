import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_01/config/color.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/detail_provider.dart';

class DetailTabbarWidget extends StatelessWidget {
  const DetailTabbarWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailInfoProvider>(
      builder: (BuildContext context, child, value) {
        var isLeft = Provider.of<DetailInfoProvider>(context, listen: false).isSelectLeft;
        var isRight = Provider.of<DetailInfoProvider>(context, listen: false).isSelectRight;
        return Container(
          padding: EdgeInsets.only(top:10),
          child: Row(
            children: <Widget>[
              _tabbarLeft(context, isLeft),
              _tabbarRight(context, isRight)
            ],
          ),
        );
      }
    );
  }

  Widget _tabbarLeft(BuildContext context, bool isLeft) {
    return InkWell(
      onTap: () {
        Provider.of<DetailInfoProvider>(context, listen: false).changeTabbar('left');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment:  Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color:Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isLeft ? KColor.themeColor:Colors.black12
            ),
          ),
        ),
        child: Text(
          '详情',
          style:TextStyle(
            fontSize: 16,
            color: isLeft ? KColor.themeColor:Colors.black54
          )
        ),
      ),
    );
  }

  Widget _tabbarRight(BuildContext context, bool isRight) {
    return InkWell(
      onTap: () {
        Provider.of<DetailInfoProvider>(context, listen: false).changeTabbar('right');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment:  Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color:Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isRight ? KColor.themeColor:Colors.black12
            ),
          ),
        ),
        child: Text(
          '评论',
          style:TextStyle(
            fontSize: 16,
            color: isRight ? KColor.themeColor:Colors.black54
          )
        ),
      ),
    );
  }
}