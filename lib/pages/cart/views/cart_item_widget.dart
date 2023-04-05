import 'package:electricity_flutter/common/page/base_text_style.dart';
import 'package:electricity_flutter/common/utils/color.dart';
import 'package:electricity_flutter/pages/cart/logics/cart_logic.dart';
import 'package:electricity_flutter/pages/cart/views/cart_item_calculate_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/page/base_placeholder_img.dart';
import '../../detail/pages/detail_page.dart';
import '../models/cart_model.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({Key? key, required this.model}) : super(key: key);
  final CartInfoModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(DetailPage(model.goodsId));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: AppColors.primaryBgColor,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            _checkBtn(context),
            _goodImage(),
            _goodName(), //商品名称和加减按钮
            _goodPrice(context),
          ],
        ),
      ),
    );
  }

  // 复选按钮
  Widget _checkBtn(context) {
    return Checkbox(
      value: model.isCheck,
      activeColor: AppColors.themeColor,
      onChanged: (isCheck) {
        CartLogic logic = Get.find();
        logic.changeCheckState(model.goodsId);
      },
    );
  }

  // 商品图片
  Widget _goodImage() {
    return Container(
      width: 75.w,
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.primaryBgColor),
      ),
      child: BaseCachedNetworkImage(url: model.image),
    );
  }

  // 商品名称
  Widget _goodName() {
    return Container(
      width: 160.w,
      padding: const EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BaseTextWidget(model.goodsName),
          CartCalculateWidget(model: model), // 加减按钮
        ],
      ),
    );
  }

  // 商品价格
  Widget _goodPrice(BuildContext context) {
    return Container(
      width: 70.w,
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          BaseTextWidget(
            '￥${model.price}',
          ),

          // 删除按钮
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: () async {
                CartLogic logic = Get.find();
                logic.deleteOneGood(model.goodsId);
              },
              child: const Icon(
                Icons.delete_forever,
                color: Colors.black26,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
