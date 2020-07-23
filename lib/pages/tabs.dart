import 'package:flutter/material.dart';
import 'catagory/pages/catagory_page.dart';
import 'home/pages/home_page.dart';
import 'home/pages/home_search_page.dart';
import 'cart/pages/cart_page.dart';
import 'mine/mine_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/color.dart';
import 'package:provider/provider.dart';
import '../config/routers/tab_index_provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Tabs extends StatelessWidget {
  final List<Widget> bottomTabs = [
    Icon(Icons.home, size: 30),
    Icon(Icons.category, size: 30),
    Icon(Icons.shopping_cart, size: 30),
    Icon(Icons.person, size: 30),
  ];

  final List<String> _titleList = ['某知名电商', '商品分类', '购物车', '我的'];
  final List<Widget> tabBodies = [
    HomePage(),
    CatagoryPage(),
    CartPage(),
    SetPage()
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);

    return Consumer<CurrentIndexProvider>(builder: (context, child, val) {
      int currentIndex =
          Provider.of<CurrentIndexProvider>(context, listen: false)
              .currentIndex;
      return Scaffold(
        appBar: currentIndex == 0
            ? AppBar(
                title: Text(_titleList[currentIndex]),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                          context: context, delegate: CustomSearchDelegate());
                    },
                  )
                ],
              )
            : AppBar(
                title: Text(_titleList[currentIndex]),
              ),
        backgroundColor: KColor.bgColor,
        bottomNavigationBar: CurvedNavigationBar(
          index: currentIndex,
          backgroundColor: KColor.themeColor,
          animationDuration: Duration(milliseconds: 300),
          items: bottomTabs,
          onTap: (index) {
            Provider.of<CurrentIndexProvider>(context, listen: false)
                .changeTabIndex(index);
          },
        ),
        body: IndexedStack(index: currentIndex, children: tabBodies),
      );
    });
  }
}
