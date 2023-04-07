import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/page/base_text_style.dart';
import '../../../common/utils/color.dart';
import '../../../common/utils/screen_utils.dart';

class CartHeadNormalWidget extends StatelessWidget {
  const CartHeadNormalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenGetWidth(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 22),
            child: Image.asset(
              "images/cart_empty_icon.png",
              width: 246.w,
            ),
          ),
          const BaseTextWidget(
            "啊哦，购物车竟然是空的",
          ),
          const SizedBox(height: 4),
          BaseTextWidget(
            "在忙，也要记得买点什么犒赏自己",
            style: baseTextStyle(
              fontSize: 12,
              color: AppColors.primarySubTitleColor153,
            ),
          ),
        ],
      ),
    );
  }
}