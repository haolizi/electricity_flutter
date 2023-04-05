import 'package:electricity_flutter/common/page/base_text_style.dart';
import 'package:electricity_flutter/common/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../logic/category_logic.dart';
import '../model/category_model.dart';

class CategoryLeftListWidget extends StatefulWidget {
  const CategoryLeftListWidget({Key? key}) : super(key: key);

  @override
  State<CategoryLeftListWidget> createState() => _CategoryLeftListWidgetState();
}

class _CategoryLeftListWidgetState extends State<CategoryLeftListWidget> {
  late CategoryGoodsLogic goodsLogic;

  @override
  void initState() {
    goodsLogic = Get.find();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 1,
            color: AppColors.primaryBgColor,
          ),
        ),
      ),
      child: GetBuilder<CategoryLogic>(builder: (logic) {
        return ListView.builder(
          itemCount: logic.leftCategoryList.length,
          itemBuilder: (context, index) {
            return _leftInkWell(logic, index);
          },
        );
      }),
    );
  }

  Widget _leftInkWell(CategoryLogic logic, int index) {
    CategoryModel model = logic.leftCategoryList[index];
    bool isClick = (index == logic.currentSection);
    return GestureDetector(
      onTap: () {
        logic.selectCategorySection(index);

        /// 请求商品列表
        goodsLogic.getLeftCategoryList(
          logic.leftCategoryList[index].mallCategoryId,
          "",
        );
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color:
              isClick ? AppColors.primaryBgColor : AppColors.white,
          border: const Border(
            bottom: BorderSide(
              width: 1,
              color: AppColors.primaryBgColor,
            ),
          ),
        ),
        child: Center(
          child: BaseTextWidget(
            model.mallCategoryName,
          ),
        ),
      ),
    );
  }

  // 请求分类列表（大分类、小分类）
  void _getCatagoryData() async {
    // await DioUtil.requestData('categoryUrl').then((value) {
    //   var data = json.decode(value.toString());
    //   CategoryModel listModel = CategoryModel.fromJson(data);
    //   setState(() {
    //     list = listModel.data;
    //   });
    //   Provider.of<ChildCategoryProvoder>(context, listen: false)
    //       .getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
    //   _getGoodsListData();
    // });
  }

  // 请求商品列表
  void _getGoodsListData(String categoryId) async {
    // String categoryId =
    //     Provider.of<ChildCategoryProvoder>(context, listen: false).categoryId;
    // Provider.of<CategoryGoodsListProvide>(context, listen: false)
    //     .getCategoryGoodsList(categoryId: categoryId, categodySubId: '');
  }
}
