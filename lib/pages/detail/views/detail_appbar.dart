import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/page/base_text_style.dart';
import '../../../common/utils/color.dart';
import '../../../common/utils/screen_utils.dart';

class DetailAppBarWidget extends StatefulWidget {
  const DetailAppBarWidget({Key? key, required this.tabTap}) : super(key: key);
  final Function(int index) tabTap;

  @override
  State<DetailAppBarWidget> createState() => DetailAppBarWidgetState();
}

class DetailAppBarWidgetState extends State<DetailAppBarWidget>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late int currentSelect = 0;
  late double currentAlpha = 0.0;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  void selectTabBarAnimation(int index) {
    tabController.animateTo(index);
  }

  void alphaChange(double alpha) {
    setState(() {
      currentAlpha = alpha;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenGetWidth(),
      height: getNavBarHeight(),
      alignment: Alignment.bottomLeft,
      color: Color.fromRGBO(228, 2, 127, currentAlpha),
      child: Row(
        children: [
          _backWidget(currentAlpha),
          Visibility(
            visible: currentAlpha > 0.6,
            child: SizedBox(
              width: screenGetWidth() - 88,
              child: _tabBarWidget(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBarWidget() {
    return TabBar(
      onTap: (index) {
        widget.tabTap(index);
      },
      controller: tabController,
      tabs: _tabBarListWidget(),
      labelColor: AppColors.white,
      unselectedLabelColor: AppColors.primarySubTitleColor242,
      labelStyle: baseTextStyle(
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: baseTextStyle(),
      indicatorColor: AppColors.white,
      indicatorSize: TabBarIndicatorSize.label,
    );
  }

  Widget _backWidget(double alpha) {
    String iconStr = "images/nav_alpha_back.png";
    if (alpha > 0.6) {
      iconStr = "images/nav_back.png";
    }
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        alignment: Alignment.center,
        width: 44,
        height: 44,
        child: Image.asset(
          iconStr,
          width: 30,
        ),
      ),
    );
  }

  List<Widget> _tabBarListWidget() {
    List list = ["商品", "详情", "评价"];
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
