/*
 * -------详情页-------
 * 评论列表
 */

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/detail_model.dart';

class DetailComments extends StatelessWidget {
  final List commentsList;
  const DetailComments({Key key, this.commentsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (commentsList.length > 0) {
      List<Widget> listWidget = commentsList.map((val) {
        return _listItem(val);
      }).toList();
      return Wrap (
        children: listWidget
      );
    } else {
      return Text('暂未有评论');
    }
  }

  Widget _listItem(GoodComments model) {
    return Row(
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(750),
          decoration: BoxDecoration(
            color:Colors.white,
            border:Border(
              bottom: BorderSide(width:1.0, color:Colors.black12)
            )
          ),
          child: Column(
            children: <Widget>[
              _userName(model),
              _commentDetail(model),
              // _creatTime(model),
            ],
          ),
        ),
      ],
    );
  }

  Widget _userName(GoodComments model) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Text(
        model.userName,
        style: TextStyle(fontSize:14),
      ),
    );
  }

  Widget _commentDetail(GoodComments model) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Text(
        model.comments,
        style: TextStyle(fontSize:14),
      ),
    );
  }

  Widget _creatTime(GoodComments model) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Text(
        '${model.discussTime}',
        style: TextStyle(fontSize:14),
      ),
    );
  }
}

