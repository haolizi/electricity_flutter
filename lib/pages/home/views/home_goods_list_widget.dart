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
            children: <Widget>[
              _hotTitle(),
              _wrapList(context)
            ],
          ),
        );
      }
    );
  }

  Widget _hotTitle() {
    return Container(
     padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      alignment: Alignment.center,
      child: Text('---推荐产品---'),
    );
  }

  Widget _wrapList(BuildContext context) {
    List<Map> goodsList = Provider.of<HomeListProvider>(context, listen: false).goodsList;
    if(goodsList.length > 0) {
      List<Widget> listWidget = goodsList.map((val) {
        return InkWell(
          onTap: () {
            ApplicationRouter.router.navigateTo(context, 'detail?id=${val['goodsId']}', transition:TransitionType.native);
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom:3.0),
            child: Column(
              children: <Widget>[
                ImageWidget(url:val['image'], w:ScreenUtil().setWidth(370)),
                Text(
                  val['name'],
                  maxLines:1,
                  overflow:TextOverflow.ellipsis,
                  style: TextStyle(color:KColor.themeColor),
                ),

                Row(
                  children: <Widget>[
                    Text("￥${val['mallPrice']}"),
                    Text(
                      "￥${val['price']}",
                      style: TextStyle(
                        color:Colors.black26,
                        decoration:TextDecoration.lineThrough
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList();
      return Wrap (
        spacing: 2,
        children: listWidget
      );
    }
    else {
      return Text('');
    }
  }  
}
