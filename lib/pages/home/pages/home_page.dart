/*
 * -------首页-------
 */

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../../config/color.dart';
import '../providers/home_provider.dart';
import '../views/home_banner_widget.dart';
import '../views/home_category_widget.dart';
import '../views/home_leader_widget.dart';
import '../views/home_recommend_widget.dart';
import '../views/home_floor_widget.dart';
import '../views/home_goods_list_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.bgColor,
      body: FutureBuilder(
        future: _getDatasInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return EasyRefresh(
              footer: ClassicalFooter(
                textColor: KColor.themeColor,
                infoColor: KColor.themeColor,
                loadText: '上拉加载更多',
                loadReadyText: '松开后开始加载',
                loadingText: '正在加载',
                loadedText: '加载完成',
                noMoreText: '没有更多内容了'
              ),
              child: ListView(
                children: <Widget>[
                  HomeBannerWidget(),    // banner
                  HomeCategoryWidget(),  // 小分类
                  LeaderInfoWidget(),    // 店长信息
                  RecommendInfoWidget(), // 推荐列表
                  FloorInfoWidget(),     // 楼层
                  GoodsListWidget(),     // 商品列表
                ],
              ),

              // 加载更多
              onLoad: () async {
                Provider.of<HomeListProvider>(context, listen: false).getListInfo();
              },
            );
          } else {
            return Center(
              child: SpinKitFadingCircle(
                color: KColor.themeColor,
                size: 50.0
              ),
            );
          }
        },
      ),
    );
  }

  // 获取首页上半部分接口homePageContent
  Future _getDatasInfo(BuildContext context) async {
    await Provider.of<HomeContentProvider>(context, listen: false).getContentInfo();
    return '加载完成';
  }
}
