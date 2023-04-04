import 'package:get/get.dart';

import '../../../common/helper/http/dio_utils.dart';
import '../../../config/api_config.dart';
import '../models/detail_model.dart';

class DetailLogic extends GetxController {
  late DetailModel detailModel = DetailModel();
  late double alpha = 0.0;

  Future getDetailInfo(String id) async {
    Map<String, String> params = {'goodId': id};
    final res = await HttpUtils.instance.post(
      Api.detailGoodsUrl,
      params: params,
    );
    if (res.success) {
      detailModel = DetailModel.fromJson(res.data);
      update();
    }
  }
}
