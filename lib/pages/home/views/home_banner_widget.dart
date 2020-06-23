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

class HomeBanner extends StatelessWidget {
  const HomeBanner({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeContentProvider>(
      builder: (BuildContext context, value, child) {
        double screenWidth = MediaQuery.of(context).size.width;
        var bannerDataList = Provider.of<HomeContentProvider>(context, listen: false).bannerList;
        return Container(
          height: 333/750*screenWidth,
          width: ScreenUtil().setWidth(750),
          child: Swiper(
            autoplay: true,
            itemCount: bannerDataList.length,
            itemBuilder: (BuildContext context, int index) {
              String imageUrl = bannerDataList[index]['image'];
              return InkWell(
                onTap: () {
                  ApplicationRouter.router.navigateTo(context, 'detail?id=${bannerDataList[index]['goodsId']}', transition: TransitionType.native);
                },
                child: ImageWidget(url: imageUrl, defImagePath:'images/home/banner_placehold.png'),
                
                // child:Image.network(
                //   imageUrl,
                //   fit: BoxFit.cover,
                // ),
              );
            },
            pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(activeColor:  KColor.themeColor),
            ),
          ),
        );
      }
    );
  }
}