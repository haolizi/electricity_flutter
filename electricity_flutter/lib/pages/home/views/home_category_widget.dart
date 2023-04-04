import 'package:electricity_flutter/main/main_tab_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/page/base_placeholder_img.dart';
import '../../../common/page/base_text_style.dart';
import '../../../common/utils/screen_utils.dart';
import '../../category/logic/category_logic.dart';
import '../models/home_content_model.dart';

class HomeCategoryWidget extends StatelessWidget {
  HomeCategoryWidget({Key? key, required this.categoryList}) : super(key: key);
  late List<Category> categoryList;

  @override
  Widget build(BuildContext context) {
    if (categoryList.length > 4) {
      categoryList = categoryList.sublist(0, 4);
    }

    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        padding: const EdgeInsets.only(top: 10),
        height: screenGetWidth() / 5 * 1.2,
        color: Colors.white,
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categoryList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemBuilder: (BuildContext context, int index) {
              return _itemWidget(index);
            }),
      ),
    );
  }

  Widget _itemWidget(int index) {
    Category categoryModel = categoryList[index];
    return GestureDetector(
      onTap: () {
        CategoryLogic categoryLogic = Get.put(CategoryLogic());
        categoryLogic.selectCategorySection(index);

        MainTabLogic tabLogic = Get.find();
        tabLogic.changeBottomBarIndex(1);
      },
      child: Column(
        children: <Widget>[
          BaseCachedNetworkImage(
            url: categoryModel.image,
            w: 50.w,
            h: 50.w,
          ),
          const SizedBox(height: 5),
          BaseTextWidget(
            categoryModel.mallCategoryName,
            style: baseTextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
