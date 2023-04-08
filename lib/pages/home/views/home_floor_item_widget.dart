import 'package:electricity_flutter/pages/detail/pages/detail_page.dart';
import 'package:electricity_flutter/pages/home/models/home_content_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/page/base_placeholder_img.dart';
import '../../../common/page/base_zoom_tap_animation.dart';
import '../../../common/utils/screen_utils.dart';

class FloorItemWidget extends StatelessWidget {
  const FloorItemWidget({Key? key, this.topImageModel, this.floorGoodsList})
      : super(key: key);
  final AdvertesPicture? topImageModel;
  final List<Floor>? floorGoodsList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        children: <Widget>[_imgWidget(), _firstRow(), _otherGoods()],
      ),
    );
  }

  Widget _imgWidget() {
    if (topImageModel == null) return const SizedBox();
    return BaseCachedNetworkImage(
      url: topImageModel!.pictureAddress,
      w: screenGetWidth(),
      onTap: () {},
    );
  }

  // 第一排是左边一张大图，右边两张小图
  Widget _firstRow() {
    if (floorGoodsList == null) return const SizedBox();
    return Container(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        children: <Widget>[
          _goodsItem(floorGoodsList![0]),
          Column(
            children: <Widget>[
              _goodsItem(floorGoodsList![1]),
              _goodsItem(floorGoodsList![2])
            ],
          ),
        ],
      ),
    );
  }

  // 第二排是左右各一张小图
  Widget _otherGoods() {
    if (floorGoodsList == null) return const SizedBox();
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList![3]),
        _goodsItem(floorGoodsList![4])
      ],
    );
  }

  // 商品item
  Widget _goodsItem(Floor goods) {
    return BaseZoomTapAnimation(
      onTap: () {
        Get.to(DetailPage(goods.goodsId));
      },
      child: SizedBox(
        width: screenGetWidth() / 2,
        child: BaseCachedNetworkImage(
          url: goods.image,
        ),
      ),
    );
  }
}
