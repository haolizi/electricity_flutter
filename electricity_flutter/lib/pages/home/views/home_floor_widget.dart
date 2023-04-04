/*
 * -------首页-------
 * 三个楼层
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../logics/home_logic.dart';
import '../models/home_content_model.dart';
import 'home_floor_item_widget.dart';

class FloorInfoWidget extends StatelessWidget {
  const FloorInfoWidget({Key? key, required this.contentModel}) : super(key: key);
  final HomeContentModel contentModel;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
          children: <Widget>[
            FloorItemWidget(
              floorGoodsList: contentModel.floor1,
              topImageModel: contentModel.floor1Pic,
            ),
            FloorItemWidget(
              floorGoodsList: contentModel.floor2,
              topImageModel: contentModel.floor2Pic,
            ),
            FloorItemWidget(
              floorGoodsList: contentModel.floor2,
              topImageModel: contentModel.floor2Pic,
            ),
          ],
        ),
    );
  }
}
