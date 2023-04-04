import 'package:electricity_flutter/common/page/base_text_style.dart';
import 'package:electricity_flutter/common/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MineHeadWidget extends StatelessWidget {
  const MineHeadWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        color: AppColors.primaryWhiteColor,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: <Widget>[
            // 头像
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ClipOval(
                child: Image.asset('images/avatar_placehold_gray.png'),
              ),
            ),

            Container(
              width: 80.w,
              height: 30.w,
              margin: const EdgeInsets.only(top: 24),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: AppColors.primaryBgColor),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: const BaseTextWidget(
                '点击登录',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
