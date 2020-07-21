/*
 * -------首页-------
 * 推荐列表
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';
import '../../../config/routers/router_application.dart';
import '../../../config/image_widget.dart';

class RecommendInfoWidget extends StatelessWidget {
  const RecommendInfoWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeContentProvider>(
        builder: (BuildContext context, value, child) {
      List recommentList =
          Provider.of<HomeContentProvider>(context, listen: false)
              .recommendList;
      return Container(
        margin: EdgeInsets.only(top: 5),
        child: Column(
          children: <Widget>[
            _titleWidget(),
            _recommentList(context, recommentList),
          ],
        ),
      );
    });
  }

  // 标题
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12)),
      ),
      child: Text('商品推荐', style: TextStyle(color: Colors.pink)),
    );
  }

  // 列表
  Widget _recommentList(BuildContext context, recommentList) {
    return Container(
      height: 180,
      child: ListView.builder(
          itemCount: recommentList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _item(context, index, recommentList);
          }),
    );
  }

  // 列表item
  Widget _item(context, index, recommentList) {
    return InkWell(
      onTap: () {
        ApplicationRouter.router.navigateTo(
            context, 'detail?id=${recommentList[index]['goodsId']}',
            transition: TransitionType.native);
      },
      child: Container(
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(left: BorderSide(width: 0.5, color: Colors.black12)),
        ),
        child: Column(
          children: <Widget>[
            ImageWidget(
              url: recommentList[index]['image'],
              w: ScreenUtil().setWidth(250),
              defImagePath: 'images/square_placehold.png',
            ),
            Text('￥${recommentList[index]['mallPrice']}'),
            Text(
              '￥${recommentList[index]['price']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
