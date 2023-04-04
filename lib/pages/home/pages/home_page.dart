import 'package:electricity_flutter/common/page/base_scaffold.dart';
import 'package:electricity_flutter/common/page/base_text_style.dart';
import 'package:electricity_flutter/common/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';

import '../../../common/page/base_refresh_footer.dart';
import '../logics/home_logic.dart';
import '../models/home_content_model.dart';
import '../models/home_goods_list_model.dart';
import '../views/home_ad_banner_widget.dart';
import '../views/home_banner_widget.dart';
import '../views/home_category_widget.dart';
import '../views/home_floor_widget.dart';
import '../views/home_goods_list_widget.dart';
import '../views/home_recommend_widget.dart';
import '../views/home_shop_info_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  late HomeContentLogic contentLogic;

  @override
  void initState() {
    contentLogic = Get.put(HomeContentLogic());
    _onRefresh();

    super.initState();
  }

  Future _onRefresh() async {
    await contentLogic.getHomeContentInfo();
  }

  Future _loadMore() async {
    await contentLogic.getHomeList(false);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BaseScaffold(
      title: "某知名电商",
      leadType: AppBarBackType.none,
      body: GetBuilder<HomeContentLogic>(builder: (logic) {
        HomeContentModel contentModel = logic.homeContentModel;
        List<GoodsModel> goodsList = logic.goodsList;
        if (contentModel.category == null) {
          return const SizedBox();
        }
        return SmartRefresher(
          controller: logic.refreshController,
          header: const WaterDropHeader(),
          footer: const BaseRefreshFooter(),
          onRefresh: _onRefresh,
          onLoading: _loadMore,
          enablePullUp: true,
          child: _scrollView(contentModel, goodsList),
        );
      }),
    );
  }

  Widget _scrollView(
      HomeContentModel contentModel, List<GoodsModel> goodsList) {
    return CustomScrollView(
      slivers: [
        /// banner
        HomeBannerWidget(bannerList: contentModel.slides!),

        /// 分类（最多显示4个）
        HomeCategoryWidget(categoryList: contentModel.category!),

        /// 店铺信息
        HomeShopInfoWidget(
          infoModel: contentModel.shopInfo!,
          adPicModel: contentModel.advertesPicture!,
        ),

        /// 会员积分广告
        HomeAdWidget(contentModel: contentModel),

        /// 推荐商品
        HomeRecommendWidget(recommend: contentModel.recommend!),

        /// 三层楼
        FloorInfoWidget(contentModel: contentModel),

        /// 底部商品列表头部
        _goodsHeaderWidget(),

        /// 底部商品列表
        HomeGoodsListWidget(goodsList: goodsList),
      ],
    );
  }

  Widget _goodsHeaderWidget() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 6, bottom: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 18,
              height: 18,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                color: AppColors.themeColor,
                borderRadius: BorderRadius.circular(9),
              ),
              child: BaseTextWidget(
                "火",
                style: baseTextStyle(
                  color: AppColors.primaryWhiteColor,
                  fontSize: 14,
                ),
              ),
            ),
            BaseTextWidget(
              "火爆专区",
              style: baseTextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
