import 'package:electricity_flutter/common/page/base_text_style.dart';
import 'package:electricity_flutter/common/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../logics/cart_logic.dart';

class CartBottomWidget extends StatelessWidget {
  const CartBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartLogic>(builder: (logic)
    {
      return Container(
        padding: const EdgeInsets.all(5.0),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            _selectAllBtn(logic),
            _allPriceArea(context, logic.allPrice),
            _buyBtn(context, logic.allGoodsCount),
          ],
        ),
      );
    });
  }

  Widget _selectAllBtn(CartLogic logic) {
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

  // 合计所在区域
  Widget _allPriceArea(context, allPrice) {
    return SizedBox(
      width: 215.w,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              // 合计
              Container(
                alignment: Alignment.centerRight,
                width: 140.w,
                child: BaseTextWidget(
                  '合计：',
                  style: baseTextStyle(fontSize: 17),
                ),
              ),

              // 价格
              Container(
                alignment: Alignment.centerLeft,
                width: 75.w,
                child: BaseTextWidget(
                  '￥${allPrice.toStringAsFixed(2)}',
                  style: baseTextStyle(
                    color: AppColors.themeColor,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),

          //底部提示文字
          Container(
            width: 215.w,
            alignment: Alignment.centerRight,
            child: BaseTextWidget(
              '满10元免配送费，预约免费配送',
              style: baseTextStyle(color: Colors.black38, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  // 结算按钮
  Widget _buyBtn(context, allGoodsCount) {
    return Container(
      width: 80.w,
      padding: const EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {
          if (allGoodsCount > 0) {
            // ApplicationRouter.router.navigateTo(context, 'order/pay',
            //     transition: TransitionType.native);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.themeColor,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: BaseTextWidget(
            '结算($allGoodsCount)',
            style: baseTextStyle(
              color: AppColors.primaryWhiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
