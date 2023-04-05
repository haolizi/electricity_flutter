import 'package:electricity_flutter/common/page/base_text_style.dart';
import 'package:electricity_flutter/common/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/page/base_sliver_header_delegate.dart';
import '../../../common/utils/screen_utils.dart';
import '../logics/detail_logic.dart';
import '../models/detail_model.dart';
import '../views/detail_appbar.dart';
import '../views/detail_bottom_widget.dart';
import '../views/detail_comment_list.dart';
import '../views/detail_goods_info.dart';
import '../views/detail_head_info.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(this.id, {Key? key}) : super(key: key);
  final String id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final GlobalKey<DetailAppBarWidgetState> appBarKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  late double goodsInfoMaxY;
  late double webHeight = 0;
  late int lastTabIndex = 0;

  @override
  void initState() {
    goodsInfoMaxY = 70.0 + screenGetWidth();
    DetailLogic logic = Get.put(DetailLogic());
    logic.getDetailInfo(widget.id);

    _onScrollListener();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBgColor,
      body: Stack(
        children: [
          GetBuilder<DetailLogic>(builder: (logic) {
            if (logic.detailModel.goodInfo == null) {
              return const SizedBox();
            }
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                _headInfoWidget(logic.detailModel.goodInfo!),
                _sliverHeaderWidget("商品详情"),
                _goodsInfoWidget(logic.detailModel.goodInfo!),
                _sliverHeaderWidget("商品评价"),
                DetailCommentsWidget(
                  commentsList: logic.detailModel.goodComments!,
                ),
              ],
            );
          }),
          Positioned(
            left: 0,
            top: 0,
            child: DetailAppBarWidget(
              key: appBarKey,
              tabTap: _changeTabIndex,
            ),
          ),
          Positioned(
            left: 0,
            bottom: getBottomBarHeight(),
            child: const DetailBottomWidget(),
          ),
        ],
      ),
    );
  }

  Widget _headInfoWidget(GoodInfo goodInfo) {
    return SliverToBoxAdapter(
      child: DetailHeadInfoWidget(
        goodInfo: goodInfo,
      ),
    );
  }

  Widget _sliverHeaderWidget(String text) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeaderDelegate(
        maxHeight: 50,
        child: Container(
          height: 50,
          color: AppColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                child: BaseTextWidget(
                  text,
                ),
              ),
              Container(
                height: 1,
                color: AppColors.primaryBgColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _goodsInfoWidget(GoodInfo goodInfo) {
    if (goodInfo.goodsDetail.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox());
    }

    return SliverToBoxAdapter(
      child: DetailWebWidget(
        goodInfo: goodInfo.goodsDetail,
        webHeight: (double height) {
          webHeight = height;
        },
      ),
    );
  }

  void _onScrollListener() {
    _scrollController.addListener(() {
      double offset = _scrollController.offset;

      if (offset <= 200) {
        double alpha = offset / 200;
        appBarKey.currentState?.alphaChange(alpha);
      }

      // tab切换使用
      int tabIndex = 0;
      if (offset < goodsInfoMaxY) {
        tabIndex = 0;
      } else if (offset >= goodsInfoMaxY &&
          offset < webHeight + goodsInfoMaxY) {
        tabIndex = 1;
      } else {
        tabIndex = 2;
      }
      if (lastTabIndex != tabIndex) {
        lastTabIndex = tabIndex;
        appBarKey.currentState?.selectTabBarAnimation(tabIndex);
      }
    });
  }

  void _changeTabIndex(int index) {
    if (lastTabIndex != index) {
      lastTabIndex = index;
      double offset = 0;
      if (index == 1) {
        offset = goodsInfoMaxY;
      } else if (index == 2) {
        offset = webHeight + goodsInfoMaxY;
      }
      _scrollController.animateTo(offset,
          duration: const Duration(milliseconds: 200), curve: Curves.ease);
    }
  }
}
