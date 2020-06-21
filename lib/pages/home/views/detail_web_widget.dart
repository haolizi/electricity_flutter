import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/detail_provider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'detail_comments_widget.dart';

class DetailWeb extends StatelessWidget {
  const DetailWeb({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailInfoProvider>(
      builder: (context, child, value) {
        var goodsDetail = Provider.of<DetailInfoProvider>(context, listen: false).detailModel.data.goodInfo.goodsDetail;
        List<dynamic> commentsList = Provider.of<DetailInfoProvider>(context, listen: false).detailModel.data.goodComments;
        var isLeft = Provider.of<DetailInfoProvider>(context, listen: false).isSelectLeft;
        if (goodsDetail != null) {
          if (isLeft) {
            return Container(
              child: Html(
                data: goodsDetail
              ),
            );
          } else {
            return Container(
              child: DetailComments(commentsList:commentsList)
            );
          }
        } else {
          return Text('加载中...');
        }
      }
    );
  }
}