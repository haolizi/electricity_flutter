/*
 * -------首页-------
 * 店长联系方式
 */

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_adbanner_widget.dart';
import 'package:flutter_01/pages/home/providers/home_provider.dart';
import 'package:provider/provider.dart';

class LeaderInfoWidget extends StatelessWidget {
  final dataInfo;
  const LeaderInfoWidget({Key key, this.dataInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeContentProvider>(
      builder: (BuildContext context, value, child) {
        HomeContentProvider homeProvider =
            Provider.of<HomeContentProvider>(context, listen: false);
        String adBannerImage = homeProvider.adBannerImage;
        String leaderInfoBgImage = homeProvider.leaderInfoBgImage;
        String leaderInfoContact = homeProvider.leaderInfoContact;
        return Container(
          margin: EdgeInsets.only(top: 5),
          child: Column(
            children: <Widget>[
              AdBannerWidget(imageUrl: adBannerImage),
              _leaderInfo(leaderInfoBgImage, leaderInfoContact)
            ],
          ),
        );
      },
    );
  }

  // 店长联系电话及背景图片
  Widget _leaderInfo(String imageUrl, String contactPhone) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: 115,
      child: InkWell(
        onTap: () {
          _leaderInfoTap(contactPhone);
        },
        child: Image.network(
          imageUrl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  void _leaderInfoTap(String contactPhone) async {
    String phoneUrl = 'tel://' + contactPhone;
    if (await canLaunch(phoneUrl)) {
      await launch(phoneUrl);
    } else {
      throw 'url不合法';
    }
  }
}
