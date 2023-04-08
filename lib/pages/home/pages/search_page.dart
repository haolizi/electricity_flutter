import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';

import '../../../common/page/base_good_item.dart';
import '../../../common/page/base_refresh_footer.dart';
import '../logics/search_logic.dart';
import '../views/search_bar_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late String searchStr = "";
  late SearchLogic searchLogic;

  @override
  void initState() {
    searchLogic = Get.put(SearchLogic());
    super.initState();
  }

  void _onRefresh() {
    searchLogic.searchGoodsList(true, searchStr);
  }

  void _loadMore() {
    searchLogic.searchGoodsList(false, searchStr);
  }

  @override
  Widget build(BuildContext context) {
    return SearchBarWidget(
      searchTap: (String search) {
        searchStr = search;
        closeKeyboard(context);
        _onRefresh();
      },
      body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanDown: (_) {
            closeKeyboard(context);
          },
          child: GetBuilder<SearchLogic>(builder: (logic) {
            return SmartRefresher(
              controller: logic.refreshController,
              header: const WaterDropHeader(),
              footer: const BaseRefreshFooter(),
              onRefresh: _onRefresh,
              onLoading: _loadMore,
              enablePullUp: true,
              child: _goodsListWidget(logic),
            );
          }),
      ),
    );
  }

  Widget _goodsListWidget(SearchLogic logic) {
    return GridView.builder(
      itemCount: logic.goodsList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.76,
      ),
      itemBuilder: (BuildContext ctx, index) {
        return GoodsItemWidget(
          goodsModel: logic.goodsList[index],
          itemWd: Get.width / 2,
        );
      },
    );
  }

  void closeKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    /// 键盘是否是弹起状态
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
