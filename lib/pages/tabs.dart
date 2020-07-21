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

class Tabs extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
    BottomNavigationBarItem(icon: Icon(Icons.category), title: Text('分类')),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart), title: Text('购物车')),
    BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('个人中心')),
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
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: KColor.themeColor,
          unselectedItemColor: Colors.black38,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
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
