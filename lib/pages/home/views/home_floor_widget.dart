/*
 * -------首页-------
 * 三个楼层
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';
import 'home_floor_item_widget.dart';


class FloorInfo extends StatelessWidget {
  const FloorInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeContentProvider>(
      builder: (BuildContext context, value, child) {
        List floor1List = Provider.of<HomeContentProvider>(context, listen: false).floor1List;
        List floor2List = Provider.of<HomeContentProvider>(context, listen: false).floor2List;
        List floor3List = Provider.of<HomeContentProvider>(context, listen: false).floor3List;
        String floor1TopImage = Provider.of<HomeContentProvider>(context, listen: false).floor1TopImage;
        String floor2TopImage = Provider.of<HomeContentProvider>(context, listen: false).floor2TopImage;
        String floor3TopImage = Provider.of<HomeContentProvider>(context, listen: false).floor3TopImage;

        return Container(
          padding: EdgeInsets.only(top: 5),
          child: Column(
            children: <Widget>[
              FloorItem(floorGoodsList: floor1List, topImage: floor1TopImage),
              FloorItem(floorGoodsList: floor2List, topImage: floor2TopImage),
              FloorItem(floorGoodsList: floor3List, topImage: floor3TopImage),
            ],
          ),
        );
      }
    );
  }
}