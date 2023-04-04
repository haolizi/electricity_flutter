/// 加减按钮

import 'package:electricity_flutter/common/page/base_text_style.dart';
import 'package:electricity_flutter/common/utils/color.dart';
import 'package:electricity_flutter/pages/cart/logics/cart_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';

class CartCalculateWidget extends StatelessWidget {
  const CartCalculateWidget({Key? key, required this.model}) : super(key: key);
  final CartInfoModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 86,
      margin: const EdgeInsets.only(top: 6.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: AppColors.primaryBgColor,
        ),
      ),
      child: Row(
        children: <Widget>[
          _reduceBtn(context),
          _numArea(context),
          _addBtn(context)
        ],
      ),
    );
  }

  // 减少按钮
  Widget _reduceBtn(context) {
    return InkWell(
      onTap: () {
        if (model.count > 1) {
          CartLogic logic = Get.find();
          logic.addOrReduceAction(model.goodsId, 2);
        }
      },
      child: Container(
        width: 24.5,
        height: 24.5,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: model.count > 1 ? Colors.white : Colors.black12,
          border: const Border(
            right: BorderSide(
              width: 1.0,
              color: AppColors.primaryBgColor,
            ),
          ),
        ),
        child: const Text('-'),
      ),
    );
  }

  // 商品数量
  Widget _numArea(context) {
    return Container(
      width: 35,
      height: 24.5,
      alignment: Alignment.center,
      color: Colors.white,
      child: BaseTextWidget('${model.count}'),
    );
  }

  // 加号按钮
  Widget _addBtn(context) {
    return InkWell(
      onTap: () {
        CartLogic logic = Get.find();
        logic.addOrReduceAction(model.goodsId, 1);
      },
      child: Container(
        width: 24.5,
        height: 24.5,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 1.0, color: AppColors.primaryBgColor),
          ),
        ),
        child: const Text('+'),
      ),
    );
  }
}
