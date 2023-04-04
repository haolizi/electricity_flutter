import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/page/base_good_item.dart';
import '../models/home_goods_list_model.dart';

class HomeGoodsListWidget extends StatelessWidget {
  const HomeGoodsListWidget({Key? key, required this.goodsList})
      : super(key: key);
  final List<GoodsModel> goodsList;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return GoodsItemWidget(goodsModel: goodsList[index]);
        },
        childCount: goodsList.length, // 内部控件数量
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
      ),
    );
  }
}
