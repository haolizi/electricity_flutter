import 'package:card_swiper/card_swiper.dart';
import 'package:electricity_flutter/common/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../common/page/base_placeholder_img.dart';
import '../../../common/utils/screen_utils.dart';
import '../../detail/pages/detail_page.dart';
import '../models/home_content_model.dart';

class HomeBannerWidget extends StatelessWidget {
  const HomeBannerWidget({Key? key, required this.bannerList})
      : super(key: key);
  final List<Slide> bannerList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 333 / 750 * screenGetWidth(),
        child: Swiper(
          autoplay: true,
          itemCount: bannerList.length,
          itemBuilder: (BuildContext context, int index) {
            Slide model = bannerList[index];
            return GestureDetector(
              onTap: () {
                Get.to(DetailPage(model.goodsId));
              },
              child: BaseCachedNetworkImage(
                url: model.image,
                w: screenGetWidth(),
                defImagePath: 'images/banner_placehold.png',
              ),
            );
          },
          pagination: const SwiperPagination(
            builder: DotSwiperPaginationBuilder(
              activeColor: AppColors.themeColor,
              size: 8.0,
              activeSize: 8.0,
            ),
          ),
        ),
      ),
    );
  }
}
