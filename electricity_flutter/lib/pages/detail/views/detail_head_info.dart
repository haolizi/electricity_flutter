import 'package:electricity_flutter/common/page/base_text_style.dart';
import 'package:electricity_flutter/common/utils/color.dart';
import 'package:flutter/cupertino.dart';

import '../../../common/page/base_placeholder_img.dart';
import '../../../common/utils/screen_utils.dart';
import '../models/detail_model.dart';

class DetailHeadInfoWidget extends StatelessWidget {
  const DetailHeadInfoWidget({Key? key, required this.goodInfo})
      : super(key: key);
  final GoodInfo goodInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _headImgWidget(),
        _goodsNameWidget(),
        _goodsNumWidget(),
        _goodsPriceWidget(),
        _instructionsWidget(),
      ],
    );
  }

  Widget _headImgWidget() {
    return BaseCachedNetworkImage(
      url: goodInfo.image1,
      w: screenGetWidth(),
      h: screenGetWidth(),
    );
  }

  Widget _goodsNameWidget() {
    return Container(
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      color: AppColors.primaryWhiteColor,
      width: double.infinity,
      child: BaseTextWidget(
        goodInfo.goodsName,
      ),
    );
  }

  Widget _goodsNumWidget() {
    return Container(
      width: double.infinity,
      height: 24,
      color: AppColors.primaryWhiteColor,
      padding: const EdgeInsets.fromLTRB(14, 6, 14, 0),
      child: BaseTextWidget(
        '编号：${goodInfo.goodsSerialNumber}',
        style: baseTextStyle(
          color: AppColors.primarySubTitleColor153,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _goodsPriceWidget() {
    return Container(
      width: double.infinity,
      height: 40,
      color: AppColors.primaryWhiteColor,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      child: Row(
        children: <Widget>[
          BaseTextWidget(
            "￥${goodInfo.presentPrice}",
            style: baseTextStyle(color: AppColors.themeColor),
          ),
          const SizedBox(width: 5),
          BaseTextWidget(
            "￥${goodInfo.oriPrice}",
            style: baseTextStyle(
              color: AppColors.primarySubTitleColor153,
              decoration: TextDecoration.lineThrough,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _instructionsWidget() {
    return Container(
      width: double.infinity,
      height: 40,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      color: AppColors.primaryWhiteColor,
      child: BaseTextWidget(
        '说明：>急速送达>正品保证',
        style: baseTextStyle(
          fontSize: 13,
          color: AppColors.themeColor,
        ),
      ),
    );
  }
}
