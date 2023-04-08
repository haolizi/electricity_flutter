import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';

import '../../../common/helper/http/dio_utils.dart';
import '../../../config/api_config.dart';
import '../models/home_goods_list_model.dart';
import '../models/search_goods_model.dart';

class SearchLogic extends GetxController {
  List<GoodsModel> goodsList = [];
  late RefreshController refreshController;
  int currentPage = 1;

  SearchLogic() {
    refreshController = RefreshController(initialRefresh: false);
  }

  Future searchGoodsList(bool isRefresh, String searchStr) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      ++currentPage;
    }
    Map<String, dynamic> formData = {'page': currentPage, 'text': searchStr};
    final res = await HttpUtils.instance.post(
      Api.searchUrl,
      params: formData,
    );
    if (res.success) {
      List<GoodsModel> resList = [];
      if (res.data != null && res.data != "") {
        for (Map<String, dynamic> json in res.data) {
          SearchGoodsModel model = SearchGoodsModel.fromJson(json);

          GoodsModel goodModel = GoodsModel(
            name: model.goodsName,
            image: model.image,
            mallPrice: model.presentPrice,
            goodsId: model.goodsId,
            price: model.presentPrice,
          );
          resList.add(goodModel);
        }
      }
      if (isRefresh == false) {
        refreshController.loadComplete();
        goodsList.addAll(resList);
        if (resList.isEmpty) {
          refreshController.loadNoData();
        }
      } else {
        goodsList.clear();
        goodsList = resList;
        refreshController.refreshCompleted();
        if (resList.isEmpty) {
          BotToast.showText(text: "搜索内容为空");
        }
      }

      update();
    } else {
      if (isRefresh == false) {
        refreshController.loadFailed();
      } else {
        refreshController.refreshFailed();
      }
    }
  }
}
