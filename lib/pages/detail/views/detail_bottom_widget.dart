import 'package:electricity_flutter/common/page/base_text_style.dart';
import 'package:electricity_flutter/common/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/utils/screen_utils.dart';
import '../../../main/main_tab_logic.dart';
import '../../cart/logics/cart_logic.dart';
import '../logics/detail_logic.dart';
import '../models/detail_model.dart';

class DetailBottomWidget extends StatelessWidget {
  const DetailBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailLogic>(builder: (logic) {
      if (logic.detailModel.goodInfo == null) {
        return const SizedBox();
      }
      GoodInfo goodInfo = logic.detailModel.goodInfo!;
      return Container(
        width: screenGetWidth(),
        color: Colors.white,
        height: 45.w,
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                // 购物车
                InkWell(
                  onTap: () {
                    MainTabLogic logic = Get.find();
                    logic.changeBottomBarIndex(2);
                    Get.back();
                  },
                  child: Container(
                    width: 55.w,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.shopping_cart,
                      size: 30,
                      color: AppColors.themeColor,
                    ),
                  ),
                ),

                _cartCountWidget(),
              ],
            ),

            // 加入购物车
            InkWell(
              onTap: () async {
                CartLogic logic = Get.find();
                logic.addGoodsToCart(goodInfo.goodsId, goodInfo.goodsName, 1,
                    goodInfo.presentPrice, goodInfo.image1);
              },
              child: Container(
                width: 160.w,
                alignment: Alignment.center,
                color: Colors.green,
                child: BaseTextWidget(
                  '加入购物车',
                  style: baseTextStyle(
                    fontSize: 16,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),

            // 立即购买
            InkWell(
              onTap: () async {
                CartLogic logic = Get.find();
                if (logic.allGoodsCount > 0) {
                  /// TODO 支付
                }
              },
              child: Container(
                color: Colors.red,
                width: 160.w,
                alignment: Alignment.center,
                child: BaseTextWidget(
                  '立即购买',
                  style: baseTextStyle(
                    fontSize: 16,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _cartCountWidget() {
    return GetBuilder<CartLogic>(builder: (logic) {
      return logic.allGoodsCount > 0
          ? Positioned(
              top: 0,
              right: 5,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(6, 3, 6, 3),
                decoration: BoxDecoration(
                    color: AppColors.themeColor,
                    border: Border.all(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(12.0)),
                child: BaseTextWidget(
                  '${logic.allGoodsCount}',
                  style: baseTextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
              ),
            )
          : const Text('');
    });
  }
}
