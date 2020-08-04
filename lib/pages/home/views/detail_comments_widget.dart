/*
 * -------详情页-------
 * 评论列表
 */

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/detail_model.dart';
import '../../../config/color.dart';

class DetailCommentsWidget extends StatelessWidget {
  final List commentsList;
  const DetailCommentsWidget({Key key, this.commentsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (commentsList.length > 0) {
      List<Widget> listWidget = commentsList.map((val) {
        return _listItem(val);
      }).toList();
      return Wrap(children: listWidget);
    } else {
      return Center(
        child: Text('暂未有评论'),
      );
    }
  }

  Widget _listItem(GoodComments model) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      width: ScreenUtil().setWidth(750),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 1.0, color: Colors.black12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _userName(model),
          _commentDetail(model),
          _creatTime(model),
        ],
      ),
    );
  }

  Widget _userName(GoodComments model) {
    return Container(
      child: Text(
        model.userName,
        style: TextStyle(color: KColor.themeColor, fontSize: 14),
      ),
    );
  }

  Widget _commentDetail(GoodComments model) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Text(
        model.comments,
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _creatTime(GoodComments model) {
    var timeStr = DateTime.fromMillisecondsSinceEpoch(model.discussTime);
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Text(
        '${timeStr.toLocal().toString()}',
        style: TextStyle(color: Colors.black54, fontSize: 12),
      ),
    );
  }
}
