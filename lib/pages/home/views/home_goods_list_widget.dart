/*
 * -------首页-------
 * 商品列表
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';
import '../../../config/routers/router_application.dart';
import '../../../config/color.dart';
import '../../../config/image_widget.dart';

class GoodsListWidget extends StatelessWidget {
  const GoodsListWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeListProvider>(
        builder: (BuildContext context, value, child) {
      return Container(
        width: ScreenUtil().setWidth(750),
        child: Column(
          children: <Widget>[_hotTitle(context), _wrapList(context)],
        ),
      );
    });
  }

  Widget _hotTitle(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Gradient gradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Colors.red, KColor.themeColor, Colors.greenAccent[700]],
    );
    // 根据gradient 创建shader
    Shader shader =
        gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      alignment: Alignment.center,
      child: Text(
        '---推荐产品---',
        style: TextStyle(foreground: Paint()..shader = shader),
      ),
    );
  }

  // 商品列表
  Widget _wrapList(BuildContext context) {
    List<Map> goodsList =
        Provider.of<HomeListProvider>(context, listen: false).goodsList;
    if (goodsList.length > 0) {
      List<Widget> listWidget = goodsList.map((val) {
        return _goodsItemWidget(context, val);
      }).toList();
      return Wrap(spacing: 2, children: listWidget);
    } else {
      return Text('');
    }
  }

  Widget _goodsItemWidget(BuildContext context, Map item) {
    return InkWell(
      onTap: () {
        ApplicationRouter.router.navigateTo(
            context, 'detail?id=${item['goodsId']}',
            transition: TransitionType.native);
      },
      child: Container(
        width: ScreenUtil().setWidth(372),
        color: Colors.white,
        padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.only(bottom: 3.0),
        child: Column(
          children: <Widget>[
            ImageWidget(
              url: item['image'],
              w: ScreenUtil().setWidth(370),
              defImagePath: 'images/home/square_placehold.png',
            ),
            Text(
              item['name'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: KColor.themeColor),
            ),
            Row(
              children: <Widget>[
                Text("￥${item['mallPrice']}"),
                Text(
                  "￥${item['price']}",
                  style: TextStyle(
                      color: Colors.black26,
                      decoration: TextDecoration.lineThrough),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
