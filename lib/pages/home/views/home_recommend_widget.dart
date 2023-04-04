import 'package:electricity_flutter/common/page/base_text_style.dart';
import 'package:electricity_flutter/common/utils/color.dart';
import 'package:electricity_flutter/pages/detail/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/page/base_placeholder_img.dart';
import '../../../common/utils/screen_utils.dart';
import '../models/home_content_model.dart';

class HomeRecommendWidget extends StatelessWidget {
  const HomeRecommendWidget({Key? key, required this.recommend})
      : super(key: key);
  final List<Recommend> recommend;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        color: Colors.white,
        child: Column(
          children: [
            _titleWidget(),
            _goodsListWidget(recommend),
          ],
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 14,
            color: AppColors.themeColor,
            margin: const EdgeInsets.only(right: 5),
          ),
          BaseTextWidget(
            "商品推荐",
            style: baseTextStyle(
              color: AppColors.themeColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _goodsListWidget(List<Recommend>? goodsList) {
    if (goodsList == null) return const SizedBox();
    double itemWd = (screenGetWidth() - 20.w) / 3;
    return SizedBox(
      height: itemWd + 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: goodsList.length,
        itemBuilder: (BuildContext context, int index) {
          Recommend model = goodsList[index];
          return GestureDetector(
            onTap: () {
              Get.to(DetailPage(model.goodsId));
            },
            child: Container(
              width: itemWd,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1, color: AppColors.primaryBgColor),
                  top: BorderSide(width: 1, color: AppColors.primaryBgColor),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BaseCachedNetworkImage(
                    url: model.image,
                    w: itemWd,
                    h: itemWd,
                  ),
                  _priceWidget(model.price, model.mallPrice),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _priceWidget(double price, double mallPrice) {
    return Column(children: [
      BaseTextWidget(
        "￥$price",
        style: baseTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      BaseTextWidget(
        "￥$mallPrice",
        style: baseTextStyle(
          fontSize: 12,
          color: AppColors.primarySubTitleColor153,
          decoration: TextDecoration.lineThrough,
        ),
      ),
    ]);
  }
}
