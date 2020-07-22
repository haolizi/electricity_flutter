import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/detail_provider.dart';
import 'detail_tabbar_irregular_widget.dart';

class DetailTabbarWidget extends StatelessWidget {
  const DetailTabbarWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailInfoProvider>(
        builder: (BuildContext context, child, value) {
      DetailInfoProvider infoProvide =
          Provider.of<DetailInfoProvider>(context, listen: false);
      var isLeft = infoProvide.isSelectLeft;
      var isRight = infoProvide.isSelectRight;
      return Container(
        color: Color.fromRGBO(250, 250, 250, 1.0),
        padding: EdgeInsets.only(top: 10),
        child: Row(
          children: <Widget>[
            _tabbarLeft(context, isLeft),
            _tabbarRight(context, isRight)
          ],
        ),
      );
    });
  }

  Widget _tabbarLeft(BuildContext context, bool isLeft) {
    return InkWell(
      onTap: () {
        Provider.of<DetailInfoProvider>(context, listen: false)
            .changeTabbar('left');
      },
      child: Stack(
        children: <Widget>[
          LeftPaintRoute(isLeft: isLeft),
          Positioned(
            top: 10,
            left: 0,
            child: Container(
              width: ScreenUtil().setWidth(375),
              alignment: Alignment.center,
              child: Text(
                '详情',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _tabbarRight(BuildContext context, bool isRight) {
    return InkWell(
      onTap: () {
        Provider.of<DetailInfoProvider>(context, listen: false)
            .changeTabbar('right');
      },
      child: Stack(
        children: <Widget>[
          RightPaintRoute(isRight: isRight),
          Positioned(
            top: 10,
            left: 0,
            child: Container(
              width: ScreenUtil().setWidth(375),
              alignment: Alignment.center,
              child: Text(
                '评论',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
