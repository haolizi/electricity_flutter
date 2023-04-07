import 'package:electricity_flutter/common/page/base_text_style.dart';
import 'package:electricity_flutter/common/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/utils/screen_utils.dart';
import '../logics/cart_logic.dart';

class CartBottomWidget extends StatelessWidget {
  const CartBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartLogic>(builder: (logic) {
      return Container(
        padding: const EdgeInsets.only(right: 5),
        color: Colors.white,
        width: screenGetWidth(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _leftSelectRow(logic),
            _rightSumRow(logic),
          ],
        ),
      );
    });
  }

  /// 复选框和全选
  Widget _leftSelectRow(CartLogic logic) {
    bool isAllCheck = logic.isAllCheck;
    return Row(
      children: <Widget>[
        Checkbox(
          value: isAllCheck,
          activeColor: AppColors.themeColor,
          onChanged: (isSelect) {
            CartLogic logic = Get.find();
            logic.changeAllCheckState(isSelect!);
          },
        ),
        const BaseTextWidget('全选')
      ],
    );
  }

  Widget _rightSumRow(CartLogic logic) {
    return Row(
      children: [
        _allPriceArea(logic.allPrice),
        _buyBtn(logic.allGoodsCount),
      ],
    );
  }

  // 合计所在区域
  Widget _allPriceArea(allPrice) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            BaseTextWidget(
              '合计：',
              style: baseTextStyle(fontSize: 17),
            ),
            BaseTextWidget(
              '￥${allPrice.toStringAsFixed(2)}',
              style: baseTextStyle(
                color: AppColors.themeColor,
                fontSize: 17,
              ),
            ),
          ],
        ),

        // 底部提示文字
        BaseTextWidget(
          '满10元免配送费，预约免费配送',
          style: baseTextStyle(color: Colors.black38, fontSize: 11),
        ),
      ],
    );
  }

  // 结算按钮
  Widget _buyBtn(allGoodsCount) {
    return InkWell(
      onTap: () {
        if (allGoodsCount > 0) {
          /// TODO 结算
        }
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.themeColor,
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: BaseTextWidget(
          '结算($allGoodsCount)',
          style: baseTextStyle(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
