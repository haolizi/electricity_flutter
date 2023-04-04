import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/utils/color.dart';
import '../../home/models/home_content_model.dart';
import '../logic/category_logic.dart';

class CategoryRightTopListWidget extends StatelessWidget {
  const CategoryRightTopListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryLogic>(
      builder: (logic) {
        return Container(
          width: 285.w,
          height: 40,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: AppColors.primaryBgColor,
              ),
            ),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: logic.childCategoryList.length,
            itemBuilder: (context, index) {
              return _rightInkWell(
                logic,
                index,
              );
            },
          ),
        );
      },
    );
  }

  Widget _rightInkWell(CategoryLogic logic, int index) {
    BxMallSubDto item = logic.childCategoryList[index];
    bool isClick = (index == logic.currentRow);
    return InkWell(
      onTap: () {
        logic.selectCategoryRow(index);

        /// 请求商品列表
        CategoryGoodsLogic goodsLogic = Get.find();
        goodsLogic.getLeftCategoryList(
          logic.childCategoryList[index].mallCategoryId,
          logic.childCategoryList[index].mallSubId,
        );
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(7, 10, 7, 10),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: 14,
            color:
                isClick ? AppColors.themeColor : AppColors.primaryTitleColor31,
          ),
        ),
      ),
    );
  }
}
