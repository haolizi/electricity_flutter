/*
 * -------首页-------
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/service_method.dart';
import '../../../config/color.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../../../config/routers/router_application.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluro/fluro.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 1;
  List<Map> hotGoodsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.bgColor,
      body: FutureBuilder(
        future: DioUtil.requestData('homePageUrl', formData:{'lon': '113.931396', 'lat': '22.525577'}),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = jsonDecode(snapshot.data.toString())['data'];
            List<Map> bannerList = (data['slides'] as List).cast();
            List<Map> categoryList = (data['category'] as List).cast();
            String adBannerImage = data['advertesPicture']['PICTURE_ADDRESS'];
            String leaderInfoBgImage = data['shopInfo']['leaderImage'];
            String leaderInfoContact = data['shopInfo']['leaderPhone'];
            List<Map> recommendList = (data['recommend'] as List).cast();

            String floor1TopImage = data['floor1Pic']['PICTURE_ADDRESS'];
            List<Map> floor1List = (data['floor1'] as List).cast();
            String floor2TopImage = data['floor2Pic']['PICTURE_ADDRESS'];
            List<Map> floor2List = (data['floor2'] as List).cast();
            String floor3TopImage = data['floor3Pic']['PICTURE_ADDRESS'];
            List<Map> floor3List = (data['floor3'] as List).cast();

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
                  TopBanner(bannerDataList: bannerList),
                  Category(categoryList: categoryList),
                  AdBanner(bgImage: adBannerImage),
                  LeaderInfo(
                      bgImage: leaderInfoBgImage,
                      contactPhone: leaderInfoContact),
                  Recommend(recommentList: recommendList),

                  // 楼层，待优化
                  FloorContent(
                      floorGoodsList: floor1List, topImage: floor1TopImage),
                  FloorContent(
                      floorGoodsList: floor2List, topImage: floor2TopImage),
                  FloorContent(
                      floorGoodsList: floor3List, topImage: floor3TopImage),

                  // 热门推荐列表
                  _hotGoods(context)
                ],
              ),

              // 加载更多
              onLoad: () async {
                var formData = {'page':currentPage};
                  await DioUtil.requestData('homePageListUrl', formData: formData).then((value) {
                  var data = json.decode(value.toString());
                  List<Map> newGoodsList = (data['data'] as List).cast();
                  setState(() {
                    hotGoodsList.addAll(newGoodsList);
                    currentPage ++;
                  });
                });
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

  Widget _hotTitle = Container(
    // margin: EdgeInsets.only(top:10.0),
    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
    alignment: Alignment.center,
    child: Text('---推荐产品---'),
  );

  Widget _wrapList(BuildContext context) {
    if(hotGoodsList.length > 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
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
                Image.network(val['image'], width: ScreenUtil().setWidth(370)),
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

  Widget _hotGoods(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _hotTitle,
          _wrapList(context),
        ],
      ),
    );
  }
}

// banner
class TopBanner extends StatelessWidget {
  final List bannerDataList;
  const TopBanner({Key key, this.bannerDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        autoplay: true,
        itemCount: bannerDataList.length,
        itemBuilder: (BuildContext context, int index) {
          String imageUrl = bannerDataList[index]['image'];
          return InkWell(
            onTap: () {
              ApplicationRouter.router.navigateTo(context, 'detail?id=${bannerDataList[index]['goodsId']}', transition: TransitionType.native);
            },
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              // height: ScreenUtil().setHeight(333),
              // width: ScreenUtil().setWidth(750),
            ),
          );
        },
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(activeColor:  KColor.themeColor),
        ),
      ),
    );
  }
}

// 小分类
class Category extends StatelessWidget {
  final List categoryList;
  const Category({Key key, this.categoryList}) : super(key: key);

  Widget _categoryListUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        // ApplicationRouter.router.navigateTo(context, 'detail?id=${item['mallCategoryId']}', transition: TransitionType.native);
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(95)),
          Text(
            item['mallCategoryName'],
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.categoryList.length > 10) {
      this.categoryList.removeRange(10, this.categoryList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(310),
      padding: EdgeInsets.all(ScreenUtil().setWidth(3.0)),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: categoryList.map((item) {
          return _categoryListUI(context, item);
        }).toList(),
      ),
    );
  }
}

//分类下的横幅广告
class AdBanner extends StatelessWidget {
  final String bgImage; 
  const AdBanner({Key key, this.bgImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          
        },
        child: Image.network(
          bgImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// 店长联系电话
class LeaderInfo extends StatelessWidget {
  final String bgImage;
  final String contactPhone;
  const LeaderInfo({Key key, this.bgImage, this.contactPhone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(230),
      child: InkWell(
        onTap: () {
          _leaderInfoTap();
        },
        child: Image.network(
          bgImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _leaderInfoTap() async {
    String phoneUrl = 'tel://' + contactPhone;
    if (await canLaunch(phoneUrl)) {
      await launch(phoneUrl);
    } else {
      throw 'url不合法';
    }
  }
}

// 商品推荐
class Recommend extends StatelessWidget {
  final List recommentList;
  const Recommend({Key key, this.recommentList}) : super(key: key);

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

  // 列表item
  Widget _item(context, index) {
    return InkWell(
      onTap: () {
        ApplicationRouter.router.navigateTo(context, 'detail?id=${recommentList[index]['goodsId']}', transition: TransitionType.native);
      },
      child: Container(
        // height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(left: BorderSide(width: 0.5, color: Colors.black12)),
        ),
        child: Column(
          children: <Widget>[
            Image.network(
              recommentList[index]['image'],
              width: ScreenUtil().setWidth(250),
              // height: ScreenUtil().setHeight(220),
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

  // 列表
  Widget _recommentList(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
          itemCount: recommentList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _item(context, index);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(391),
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(10.0)),
      child: Column(
        children: <Widget>[
          _titleWidget(), 
          _recommentList(context)
        ],
      ),
    );
  }
}

// 楼层
class FloorContent extends StatelessWidget {
  final String topImage;
  final List floorGoodsList;

  const FloorContent({Key key, this.floorGoodsList, this.topImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Column(
        children: <Widget>[
          AdBanner(bgImage: topImage),
          _firstRow(context),
          _otherGoods(context)
        ],
      ),
    );
  }

  // 第一排是左边一张大图，右边两张小图
  Widget _firstRow(context) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Row(
        children: <Widget>[
          _goodsItem(context, floorGoodsList[0]),
          Column(
            children: <Widget>[
              _goodsItem(context, floorGoodsList[1]),
              _goodsItem(context, floorGoodsList[2])
            ],
          ),
        ],
      ),
    );
  }

  // 第二排是左右各一张小图
  Widget _otherGoods(context) {
    return Row(
      children: <Widget>[
        _goodsItem(context, floorGoodsList[3]),
        _goodsItem(context, floorGoodsList[4])
      ],
    );
  }

  // 商品item
  Widget _goodsItem(context, Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {
          ApplicationRouter.router.navigateTo(context, 'detail?id=${goods['goodsId']}', transition: TransitionType.native);
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}

