import 'package:get/get.dart';

import '../../../common/helper/http/dio_utils.dart';
import '../../../config/api_config.dart';
import '../../home/models/home_content_model.dart';
import '../../home/models/home_goods_list_model.dart';
import '../model/category_model.dart';

class CategoryLogic extends GetxController {
  List<CategoryModel> leftCategoryList = [];
  List<BxMallSubDto> childCategoryList = [];
  int currentSection = 0; // 左边大分类选择
  int currentRow = 0; // 右顶部小分类选择

  // 小分类添加全部
  BxMallSubDto mallDto =
      BxMallSubDto(mallSubId: "", mallCategoryId: "00", mallSubName: "全部");

  Future getLeftCategoryList() async {
    final res = await HttpUtils.instance.post(
      Api.categoryUrl,
    );
    if (res.success) {
      List<CategoryModel> list = List<CategoryModel>.from(
          res.data.map((x) => CategoryModel.fromJson(x)));

      /// 所有子分类添加全部
      leftCategoryList.clear();
      for (CategoryModel model in list) {
        model.bxMallSubDto.insert(0, mallDto);
        leftCategoryList.add(model);
      }

      /// 默认选中第一个
      if (leftCategoryList.isNotEmpty) {
        childCategoryList = leftCategoryList.first.bxMallSubDto;
        mallDto.mallCategoryId = leftCategoryList.first.mallCategoryId;
      }
    }
    update();
  }

  selectCategorySection(int index) {
    currentSection = index;
    currentRow = 0;
    childCategoryList = leftCategoryList[index].bxMallSubDto;
    update();
  }

  selectCategoryRow(int index) {
    currentRow = index;
    update();
  }
}

class CategoryGoodsLogic extends GetxController {
  List<GoodsModel> goodsList = [];

  Future getLeftCategoryList(String categoryId, String categorySubId) async {
    var formData = {'categoryId': categoryId, 'categorySubId': categorySubId};

    final res = await HttpUtils.instance.post(
      Api.categoryGoodsListUrl,
      params: formData,
    );
    if (res.success) {
      goodsList.clear();
      if (res.data != null && res.data != "") {
        for (Map<String, dynamic> json in res.data) {
          CategoryGoodModel model = CategoryGoodModel.fromJson(json);
          /// 首页和分类页商品，共用widget，但是后台返回字段又不同，这里映射成同一个model
          GoodsModel goodModel = GoodsModel(
            name: model.goodsName,
            image: model.image,
            mallPrice: model.oriPrice,
            goodsId: model.goodsId,
            price: model.presentPrice,
          );
          goodsList.add(goodModel);
        }
      }
      update();
    }
  }
}
