import 'package:electricity_flutter/common/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/page/base_placeholder_img.dart';
import '../../../common/utils/screen_utils.dart';
import '../models/home_content_model.dart';

class HomeShopInfoWidget extends StatelessWidget {
  const HomeShopInfoWidget(
      {Key? key, required this.infoModel, required this.adPicModel})
      : super(key: key);
  final ShopInfo infoModel;
  final AdvertesPicture adPicModel;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {
          _launchUrl(infoModel.leaderPhone);
        },
        child: Container(
          color: AppColors.white,
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Column(
            children: [
              _shopInfoWidget(),
              _shopImgWidget(infoModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget _shopInfoWidget() {
    return BaseCachedNetworkImage(
      url: adPicModel.pictureAddress,
      w: screenGetWidth(),
      h: 34.w,
      defImagePath: "images/banner_placehold.png",
    );
  }

  Widget _shopImgWidget(ShopInfo infoModel) {
    return BaseCachedNetworkImage(
      url: infoModel.leaderImage,
      w: screenGetWidth(),
      h: 115.w,
      defImagePath: "images/banner_placehold.png",
    );
  }

  Future<void> _launchUrl(String phone) async {
    // canLaunchUrl(Uri(scheme: 'tel', path: phone)).then((bool result) {
    //   debugPrint("-----callResult:$result");
    // });
  }
}
