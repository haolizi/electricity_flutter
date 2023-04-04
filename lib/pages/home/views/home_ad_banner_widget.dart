import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../common/page/base_placeholder_img.dart';
import '../../../common/utils/screen_utils.dart';
import '../logics/home_logic.dart';
import '../models/home_content_model.dart';

class HomeAdWidget extends StatelessWidget {
  const HomeAdWidget({Key? key, required this.contentModel}) : super(key: key);
   final HomeContentModel contentModel;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
          children: [
            _imgWidget(contentModel.saoma?.pictureAddress),
            _imgWidget(contentModel.integralMallPic?.pictureAddress),
            _imgWidget(contentModel.newUser?.pictureAddress),
          ],
        ),
    );
  }

  Widget _imgWidget(String? url) {
    return BaseCachedNetworkImage(
      url: url ?? "",
      w: screenGetWidth() / 3,
      h: 167.w,
      defImagePath: "images/category_placehold.png",
    );
  }
}
