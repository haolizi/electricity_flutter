import 'package:electricity_flutter/common/utils/color.dart';
import 'package:electricity_flutter/pages/cart/pages/cart_page.dart';
import 'package:electricity_flutter/pages/category/pages/category_page.dart';
import 'package:electricity_flutter/pages/mine/pages/mine_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/home/pages/home_page.dart';
import 'main_tab_logic.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final globalStateLogic = Get.put(MainTabLogic());
    var mainState = Get.find<MainTabLogic>().state;
    return Scaffold(
      body: Obx(
            () => IndexedStack(
          index: mainState.bottomIndex.value,
          children: bodyPageList,
        ),
      ),
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          currentIndex: mainState.bottomIndex.value,
          onTap: (int index) {
            globalStateLogic.changeBottomBarIndex(index);
          },
          iconSize: 30.0,
          fixedColor: AppColors.themeColor,
          type: BottomNavigationBarType.fixed,
          items: bottomNavBarList,
        ),
      ),
    );
  }

  final List<Widget> bodyPageList = const [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MinePage(),
  ];

  final List<BottomNavigationBarItem> bottomNavBarList = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
    BottomNavigationBarItem(icon: Icon(Icons.category), label: "分类"),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "购物车"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的"),
  ];
}
