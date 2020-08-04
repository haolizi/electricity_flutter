/*
 * -------首页-------
 * 三个楼层
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';
import 'home_floor_item_widget.dart';

class FloorInfoWidget extends StatelessWidget {
  const FloorInfoWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeContentProvider>(
        builder: (BuildContext context, value, child) {
      List floor1List = value.floor1List;
      List floor2List = value.floor2List;
      List floor3List = value.floor3List;
      String floor1TopImage = value.floor1TopImage;
      String floor2TopImage = value.floor2TopImage;
      String floor3TopImage = value.floor3TopImage;

      return Container(
        padding: EdgeInsets.only(top: 5),
        child: Column(
          children: <Widget>[
            FloorItemWidget(
                floorGoodsList: floor1List, topImage: floor1TopImage),
            FloorItemWidget(
                floorGoodsList: floor2List, topImage: floor2TopImage),
            FloorItemWidget(
                floorGoodsList: floor3List, topImage: floor3TopImage),
          ],
        ),
      );
    });
  }
}
