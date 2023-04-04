import 'package:get/get.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';

import '../../../common/helper/http/dio_utils.dart';
import '../../../config/api_config.dart';
import '../../../config/config.dart';
import '../models/home_content_model.dart';
import '../models/home_goods_list_model.dart';

class HomeContentLogic extends GetxController {
  late HomeContentModel homeContentModel =
      HomeContentModel();
  List<GoodsModel> goodsList = [];
  late RefreshController refreshController;
  int currentPage = 1;

  HomeContentLogic() {
    refreshController = RefreshController(initialRefresh: false);
  }

  Future getHomeContentInfo() async {
    Map<String, String> params = {'lon': '113.931396', 'lat': '22.525577'};
    final res = await HttpUtils.instance.post(
      Api.homePageUrl,
      params: params,
    );
    if (res.success) {
      refreshController.refreshCompleted();
      homeContentModel = HomeContentModel.fromJson(res.data);
      update();

      getHomeList(true);
    } else {
      refreshController.refreshFailed();
    }
  }

  Future getHomeList(
      bool isRefresh) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      ++currentPage;
    }
    Map<String, int> formData = {
      'page': currentPage,
      'pageSize': Config.pageSize
    };
    final res = await HttpUtils.instance.post(
      Api.homePageListUrl,
      params: formData,
    );
    if (res.success) {
      List<GoodsModel> list =
          List<GoodsModel>.from(res.data.map((x) => GoodsModel.fromJson(x)));
      if (isRefresh == false) {
        refreshController.loadComplete();
        goodsList.addAll(list);
      } else {
        goodsList.clear();
        goodsList = list;
      }
      if (goodsList.isEmpty) {
        refreshController.loadNoData();
      }
      update();
    } else {
      refreshController.loadFailed();
    }
  }
}

