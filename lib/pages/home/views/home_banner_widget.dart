/*
 * -------首页-------
 * banner
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';
import '../../../config/routers/router_application.dart';
import '../../../config/color.dart';
import '../../../config/image_widget.dart';

class HomeBannerWidget extends StatelessWidget {
  const HomeBannerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeContentProvider>(
        builder: (BuildContext context, value, child) {
      double screenWidth = MediaQuery.of(context).size.width;
      return Container(
        height: 333 / 750 * screenWidth,
        width: ScreenUtil().setWidth(750),
        child: Swiper(
          autoplay: true,
          itemCount: value.bannerList.length,
          itemBuilder: (BuildContext context, int index) {
            String imageUrl = value.bannerList[index]['image'];
            return InkWell(
              onTap: () {
                ApplicationRouter.router.navigateTo(
                    context, 'detail?id=${value.bannerList[index]['goodsId']}',
                    transition: TransitionType.native);
              },
              child: ImageWidget(
                  url: imageUrl,
                  w: ScreenUtil().setWidth(750),
                  defImagePath: 'images/home/banner_placehold.png'),
            );
          },
          pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(activeColor: KColor.themeColor),
          ),
        ),
      );
    });
  }
}
