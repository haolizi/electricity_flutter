import 'package:electricity_flutter/common/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/page/base_good_item.dart';
import '../../../common/page/base_scaffold.dart';
import '../logic/category_logic.dart';
import '../views/category_left_list_widget.dart';
import '../views/category_right_top_list_widget.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    CategoryLogic logic = Get.put(CategoryLogic());

    /// 请求分类
    CategoryGoodsLogic goodsLogic = Get.put(CategoryGoodsLogic());
    logic.getLeftCategoryList().then((value) {
      if (logic.leftCategoryList.isNotEmpty) {
        /// 请求商品列表
        goodsLogic.getLeftCategoryList(logic.mallDto.mallCategoryId, "");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BaseScaffold(
      title: "商品分类",
      leadType: AppBarBackType.none,
      backgroundColor: AppColors.white,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CategoryLeftListWidget(),
          Column(
            children: [
              const CategoryRightTopListWidget(),
              _rightListWidget(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _rightListWidget() {
    return GetBuilder<CategoryGoodsLogic>(builder: (logic) {
      return Expanded(
        child: SizedBox(
          width: 285.w,
          child: GridView.builder(
              itemCount: logic.goodsList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.76,
              ),
              itemBuilder: (BuildContext ctx, index) {
                return GoodsItemWidget(
                  goodsModel: logic.goodsList[index],
                  itemWd: 285.w / 2,
                );
              }),
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
