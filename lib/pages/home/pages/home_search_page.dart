import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../../../config/request/service_method.dart';
import '../models/search_goods_model.dart';
import '../../../config/routers/router_application.dart';
import '../../../config/color.dart';
import '../../../config/image_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';

class CustomSearchDelegate extends SearchDelegate {
  SearchGoodsModel goodsModel;
  // 显示在输入框之后的部件
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(
          Icons.clear,
          color: Colors.black,
        ),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }

  // 显示在输入框之前的部件，一般显示返回前一个页面箭头按钮
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  // 显示搜索建议
  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('');
  }

  // 显示搜索结果
  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: _getSearchDatas(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (goodsModel.data.length > 0) {
            return _goodsListWidget(context);
          } else {
            return Container(
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.topCenter,
              child: Text('没有更多数据'),
            );
          }
        } else {
          return Center(
            child: SpinKitFadingCircle(color: KColor.themeColor, size: 50.0),
          );
        }
      },
    );
  }

  // 商品列表
  Widget _goodsListWidget(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 5.0,
      mainAxisSpacing: 5.0,
      childAspectRatio: 0.8,
      padding: EdgeInsets.all(5.0),
      children: _listWidget(context, goodsModel.data),
    );
  }

  List<Widget> _listWidget(
      BuildContext context, List<GoodsModel> categoryList) {
    return categoryList
        .map((model) => _goodsItemWidget(context, model))
        .toList();
  }

  // 商品小模块
  Widget _goodsItemWidget(BuildContext context, GoodsModel model) {
    return InkWell(
      onTap: () {
        ApplicationRouter.router.navigateTo(
          context,
          'detail?id=${model.goodsId}',
          transition: TransitionType.native,
        );
      },
      child: Container(
        width: ScreenUtil().setWidth(372),
        color: Colors.white,
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            ImageWidget(
              url: model.image,
              w: ScreenUtil().setWidth(370),
              defImagePath: 'images/home/square_placehold.png',
            ),
            Text(
              model.goodsName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: KColor.themeColor),
            ),
            Row(
              children: <Widget>[
                Text("￥${model.pRESENTPRICE}"),
                Text(
                  "￥${model.price}",
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

  // 搜索
  Future _getSearchDatas(String searchStr) async {
    var formData = {'page': '1', 'text': searchStr, 'categoryId': ''};
    await DioUtil.requestData('searchPageUrl', formData: formData)
        .then((value) {
      var data = json.decode(value.toString());
      print('------search:${data}');
      goodsModel = SearchGoodsModel.fromJson(data);
    });

    return '加载完成';
  }
}
