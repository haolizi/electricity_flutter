/*
 * -------首页-------
 * 小分类
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/home_provider.dart';
import 'package:provider/provider.dart';
import '../../../config/image_widget.dart';

class HomeCategory extends StatelessWidget {
  const HomeCategory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List categoryList = Provider.of<HomeContentProvider>(context, listen: false).categoryList;
    if (categoryList.length > 10) {
      categoryList.removeRange(10, categoryList.length);
    }
    return Consumer<HomeContentProvider>(
      builder: (BuildContext context, value, child) {
        return Container(
          height: 165,
          padding: EdgeInsets.all(ScreenUtil().setWidth(3.0)),
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 5,
            padding: EdgeInsets.all(5.0),
            children: categoryList.map((item) {
              return _categoryItem(context, item);
            }).toList(),
          ),
        );
      }
    );
  }
}

Widget _categoryItem(BuildContext context, item) {
  return InkWell(
    onTap: () {
      // ApplicationRouter.router.navigateTo(context, 'detail?id=${item['mallCategoryId']}', transition: TransitionType.native);
    },
    child: Column(
      children: <Widget>[
        ImageWidget(url: item['image'], w:ScreenUtil().setWidth(95)),
        // Image.network(item['image'], width: ScreenUtil().setWidth(95)),
        Text(
          item['mallCategoryName'],
          style: TextStyle(fontSize: 14),
        ),
      ],
    ),
  );
}
