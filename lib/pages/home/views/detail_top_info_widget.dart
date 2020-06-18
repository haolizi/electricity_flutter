/*
 * -------详情页-------
 * 头部图片、标题、价格、说明信息
 */

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/detail_provider.dart';
import '../../../config/color.dart';

class DetailTopInfo extends StatelessWidget {
  const DetailTopInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailInfoProvider>(
      builder: (BuildContext context, goodsData, child) {
        var goodsInfo = Provider.of<DetailInfoProvider>(context, listen: false).detailModel.data.goodInfo;
        if(goodsInfo != null) {
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _topImage(goodsInfo.image1),
                _goodsName(goodsInfo.goodsName),
                _goodsNum(goodsInfo.goodsSerialNumber),
                _goodsPrice(goodsInfo.presentPrice, goodsInfo.oriPrice)
              ],
            ),
          );
        } else {
          return Text('加载中');
        }
      },
    );
  }

  Widget _topImage(url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
    );
  }

  Widget _goodsName(name) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(left: 14),
      margin: EdgeInsets.only(top:10),
      child: Text(
        name,
        style: TextStyle(fontSize:16),
      ),
    );
  }

  Widget _goodsNum(num) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(left: 14),
      margin: EdgeInsets.only(top:10),
      child: Text(
        '编号：${num}',
        style: TextStyle(color:Colors.black38),
      ),
    );
  }

  Widget _goodsPrice (price, originalPrice) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.fromLTRB(14, 10, 14, 10),
      child: Row(
        children: <Widget>[
          Text(
            "￥${price}",
            style: TextStyle(fontSize:18, color:Colors.red),
          ),
          
          Text(
            "￥${originalPrice}",
            style: TextStyle(
              color:Colors.black26,
              decoration:TextDecoration.lineThrough
            ),
          ),
        ],
      ),
    );
  }
}

class DetailInstructions extends StatelessWidget {
  const DetailInstructions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.fromLTRB(14, 10, 14, 10),
      color: Colors.white,
      child: Text(
        '说明：>急速送达>正品保证',
        style: TextStyle(color:KColor.themeColor),
      ),
    );
  }
}