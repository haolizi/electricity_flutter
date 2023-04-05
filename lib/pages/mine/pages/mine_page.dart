/*
 * 我的页面
 */

import 'package:electricity_flutter/common/page/base_scaffold.dart';
import 'package:electricity_flutter/common/page/base_text_style.dart';
import 'package:electricity_flutter/common/utils/color.dart';
import 'package:flutter/material.dart';

import '../views/mine_head_widget.dart';
import '../views/mine_list_widget.dart';
import '../views/mine_order_status_widget.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BaseScaffold(
      title: "我的",
      leadType: AppBarBackType.none,
      body: CustomScrollView(
        slivers: [
          const MineHeadWidget(),
          _mineOrderInfoWidget(),
          const MineOrderStatusWidget(),
          const ListTitleWidget(),
        ],
      ),
    );
  }

  Widget _mineOrderInfoWidget() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: AppColors.primaryBgColor),
          ),
        ),
        child: ListTile(
          leading: Image.asset('images/mine_order_list.png'),
          title: const BaseTextWidget(
            '我的订单',
          ),
          trailing: Image.asset('images/right_arrow.png'),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
