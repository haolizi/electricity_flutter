import 'package:electricity_flutter/common/page/base_text_style.dart';
import 'package:electricity_flutter/common/utils/color.dart';
import 'package:flutter/material.dart';

class ListTitleWidget extends StatelessWidget {
  const ListTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((content, index) {
        return _listItem(itemList[index]);
      }, childCount: itemList.length),
    );
  }

  Widget _listItem(Map item) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: AppColors.primaryBgColor),
        ),
      ),
      child: ListTile(
        leading: Image.asset(item["icon"]),
        title: BaseTextWidget(
          item["title"],
        ),
        trailing: Image.asset('images/right_arrow.png'),
      ),
    );
  }
}

List itemList = [
  {'icon': 'images/mine_coupons.png', 'title': '领取优惠券'},
  {'icon': 'images/mine_coupons.png', 'title': '已领取优惠券'},
  {'icon': 'images/mine_position.png', 'title': '地址管理'},
  {'icon': 'images/mine_service.png', 'title': '客服电话'},
  {'icon': 'images/mine_about.png', 'title': '关于我们'}
];
