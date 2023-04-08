class Api {
  /// 前缀
  static const String api = "baixing/wxmini";

  static const String homePageUrl = '$api/homePageContent'; // 首页内容数据
  static const String homePageListUrl = '$api/homePageBelowConten'; // 首页底部推荐列表
  static const String categoryUrl = '$api/getCategory'; // 分类页
  static const String categoryGoodsListUrl = '$api/getMallGoods'; // 分类页商品列表
  static const String detailGoodsUrl = '$api/getGoodDetailById'; // 商品详情页
  static const String searchUrl = '$api/searchGoods'; // 搜索
}
