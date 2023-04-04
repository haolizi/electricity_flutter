import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/detail/pages/detail_page.dart';
import '../../pages/home/models/home_goods_list_model.dart';
import '../utils/color.dart';
import '../utils/screen_utils.dart';
import 'base_placeholder_img.dart';
import 'base_text_style.dart';

class GoodsItemWidget extends StatelessWidget {
  const GoodsItemWidget({Key? key, required this.goodsModel, this.itemWd})
      : super(key: key);
  final GoodsModel goodsModel;
  final double? itemWd;

  @override
  Widget build(BuildContext context) {
    return _itemWidget();
  }

  Widget _itemWidget() {
    return GestureDetector(
      onTap: () {
        Get.to(DetailPage(goodsModel.goodsId));
      },
      child: Container(
        width: itemWd ?? screenGetWidth() / 2,
        color: AppColors.primaryWhiteColor,
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            BaseCachedNetworkImage(
              url: goodsModel.image,
              w: screenGetWidth() / 2 - 10,
            ),
            Text(
              goodsModel.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.themeColor),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 30, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("￥${goodsModel.mallPrice}"),
                  BaseTextWidget(
                    "￥${goodsModel.price}",
                    style: baseTextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: AppColors.primarySubTitleColor153,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
