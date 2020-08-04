/*
 * -------首页-------
 * 小分类
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/home_provider.dart';
import 'package:provider/provider.dart';
import '../../../config/image_widget.dart';
import '../../../config/routers/tab_index_provider.dart';

class HomeCategoryWidget extends StatelessWidget {
  const HomeCategoryWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = 0.0;
    List categoryList =
        Provider.of<HomeContentProvider>(context, listen: false).categoryList;
    height = ((categoryList.length - 1) ~/ 5 + 1) * 78.toDouble();

    return Container(
      height: ScreenUtil().setWidth(2 * height - 30),
      padding: EdgeInsets.all(ScreenUtil().setWidth(3.0)),
      color: Colors.white,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: _listWidget(context, categoryList),
      ),
    );
  }

  List<Widget> _listWidget(BuildContext context, List<Map> categoryList) {
    return categoryList.map((item) => _categoryItem(context, item)).toList();
  }
}

Widget _categoryItem(BuildContext context, item) {
  return InkWell(
    onTap: () {
      Provider.of<CurrentIndexProvider>(context, listen: false)
          .changeTabIndex(1);
    },
    child: Column(
      children: <Widget>[
        ImageWidget(
          url: item['image'],
          w: ScreenUtil().setWidth(80),
          h: ScreenUtil().setWidth(80),
          defImagePath: 'images/home/category_placehold.png',
        ),
        SizedBox(height: 5),
        Text(
          item['mallCategoryName'],
          style: TextStyle(fontSize: 13),
        ),
      ],
    ),
  );
}
