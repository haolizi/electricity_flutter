import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/detail_provider.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailWeb extends StatelessWidget {
  const DetailWeb({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailInfoProvider>(
      builder: (context, child, value) {
        var goodsDetail = Provider.of<DetailInfoProvider>(context, listen: false).detailModel.data.goodInfo.goodsDetail;
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
              width: ScreenUtil().setWidth(750),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text('暂时没有数据'),
            );
          }
        } else {
          return Text('加载中...');
        }
      }
    );
  }
}