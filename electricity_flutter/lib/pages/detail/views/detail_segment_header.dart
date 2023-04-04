import 'package:electricity_flutter/common/page/base_text_style.dart';
import 'package:electricity_flutter/common/utils/color.dart';
import 'package:flutter/material.dart';

import '../../../common/page/base_sliver_header_delegate.dart';

class SegmentHeaderWidget extends StatefulWidget {
  const SegmentHeaderWidget({Key? key}) : super(key: key);

  @override
  State<SegmentHeaderWidget> createState() => _SegmentHeaderWidgetState();
}

class _SegmentHeaderWidgetState extends State<SegmentHeaderWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        // homeLogic.changeTabIndex(_tabController.index);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: false,
      delegate: SliverHeaderDelegate(
          //有最大和最小高度
          maxHeight: 50,
          minHeight: 50,
          child: Container(
            color: AppColors.primaryWhiteColor,
            child: TabBar(
              controller: _tabController,
              tabs: _tabBarListWidget(),
              labelColor: AppColors.themeColor,
              unselectedLabelColor: AppColors.primarySubTitleColor153,
              labelStyle: baseTextStyle(),
              unselectedLabelStyle: baseTextStyle(),
              indicatorColor: AppColors.themeColor,
            ),
          )),
    );
  }

  List<Widget> _tabBarListWidget() {
    List list = ["详情", "评论"];
    List<Widget> tabList = [];
    for (String text in list) {
      tabList.add(
        Tab(
          text: text,
        ),
      );
    }
    return tabList;
  }
}
