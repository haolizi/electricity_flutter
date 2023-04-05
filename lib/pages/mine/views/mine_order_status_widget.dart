/*
 * 我的页面-订单
 */

import 'package:electricity_flutter/common/page/base_text_style.dart';
import 'package:electricity_flutter/common/utils/color.dart';
import 'package:flutter/material.dart';

class MineOrderStatusWidget extends StatelessWidget {
  const MineOrderStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 75.0,
        color: AppColors.white,
        margin: const EdgeInsets.only(bottom: 10),
        child: GridView.count(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          children: itemList.map((item) {
            return _categoryItem(context, item);
          }).toList(),
        ),
      ),
    );
  }

  Widget _categoryItem(BuildContext context, item) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Image.asset(item['icon']),
          const SizedBox(height: 5),
          BaseTextWidget(
            item['title'],
            style: baseTextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}

List itemList = [
  {'icon': 'images/wait_pay.png', 'title': '待付款'},
  {'icon': 'images/wait_delivery.png', 'title': '待发货'},
  {'icon': 'images/wait_harvest.png', 'title': '待收获'},
  {'icon': 'images/wait_evaluate.png', 'title': '待评价'}
];
