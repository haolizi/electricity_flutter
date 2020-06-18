import 'package:flutter/material.dart';
import 'catagory/pages/catagory_page.dart';
import 'home/pages/home_page.dart';
import 'cart/pages/cart_page.dart';
import 'mine/mine_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/color.dart';

class Tabs extends StatefulWidget {
  Tabs({Key key}) : super(key: key);
  @override
  _TabsState createState() => _TabsState();
}
 
class _TabsState extends State<Tabs> {
  PageController _pageController;
  
  final List<Widget> _pageList = [HomePage(), CatagoryPage(), CartPage(), SetPage()];
  List _titleList = ['某知名电商', '商品分类','购物车', 'Set'];
  int _currentIndex = 0;
  var currentPage;
  
  @override
  void initState() { 
    currentPage = _pageList[_currentIndex];
    _pageController = new PageController()
      ..addListener(() {
        if(currentPage != _pageController.page.round()) {
          setState(() {
            currentPage = _pageController.page.round();
          });
        }
      });
    super.initState();
  } 

  @override
  Widget build(BuildContext context) {

    // 设计稿以6的尺寸设计
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true); 

    return Scaffold(
      appBar: AppBar(title: Text(_titleList[_currentIndex])),
      body: IndexedStack(
        index:_currentIndex,
        children: _pageList,
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: KColor.themeColor,
        unselectedItemColor: Colors.black38,
        showUnselectedLabels:true,
        currentIndex: this._currentIndex,
        onTap: (int index) {
          setState(() {
            this._currentIndex = index;
            currentPage = _pageList[_currentIndex];
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),     title: Text('首页')),
          BottomNavigationBarItem(icon: Icon(Icons.category), title: Text('分类')),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), title: Text('购物车')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('我的')),
        ],
      ),
    );
  }
}

