/*
 * -------详情页-------
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/detail_provider.dart';
import '../views/detail_top_info_widget.dart';
import '../views/detail_tabbar_widget.dart';
import '../views/detail_web_widget.dart';
import '../views/detail_bottom_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../config/color.dart';

class HomeDetailPage extends StatelessWidget {
  final String goodsId;
  const HomeDetailPage({Key key, this.goodsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('商品详情')
      ),
      body: FutureBuilder(
        future: _getDetailsInfo(context),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom:45), 
                  child: ListView(
                    children: <Widget>[
                      DetailTopInfo(),       // 头部图片、标题、价格、说明信息
                      DetailInstructions(),  // 说明
                      DetailTabbar(),        // segment
                      DetailWeb(),           // 商品详情及评论
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: DetailBottom()
                ),
              ],
            );
          } else {
            return Center(
              child: SpinKitFadingCircle(
                color: KColor.themeColor,
                size: 50.0
              ),
            );
          }
        }
      ),
    );
  }

  Future _getDetailsInfo(BuildContext context) async {
    await Provider.of<DetailInfoProvider>(context, listen: false).getGoodsInfo(goodsId);
    return '加载完成';
  }
}

Widget TabbarDetail() {
  return Text('1111111111');
}
