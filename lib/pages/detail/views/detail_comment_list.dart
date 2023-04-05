import 'package:electricity_flutter/common/page/base_text_style.dart';
import 'package:electricity_flutter/common/utils/color.dart';
import 'package:flutter/cupertino.dart';

import '../../../common/utils/screen_utils.dart';
import '../models/detail_model.dart';

class DetailCommentsWidget extends StatelessWidget {
  const DetailCommentsWidget({Key? key, required this.commentsList})
      : super(key: key);
  final List<GoodComment> commentsList;

  @override
  Widget build(BuildContext context) {
    if (commentsList.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(child: Text('暂未有评论')),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (content, index) {
          return _listItem(commentsList[index]);
        },
        childCount: commentsList.length,
      ),
    );
  }

  Widget _listItem(GoodComment model) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      width: screenGetWidth(),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: AppColors.primaryBgColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _userName(model),
          _commentDetail(model),
          _createTime(model),
        ],
      ),
    );
  }

  Widget _userName(GoodComment model) {
    return BaseTextWidget(
      model.userName,
      style: baseTextStyle(
        color: AppColors.themeColor,
      ),
    );
  }

  Widget _commentDetail(GoodComment model) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: BaseTextWidget(
        model.comments,
      ),
    );
  }

  Widget _createTime(GoodComment model) {
    var timeStr = DateTime.fromMillisecondsSinceEpoch(model.discussTime);
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: BaseTextWidget(
        timeStr.toLocal().toString(),
        style: const TextStyle(
          color: AppColors.primarySubTitleColor153,
          fontSize: 12,
        ),
      ),
    );
  }
}
