/*
 * -------首页-------
 * 横幅广告
 */

import 'package:flutter/material.dart';

class AdBannerWidget extends StatelessWidget {
  final String imageUrl;
  const AdBannerWidget({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          
        },
        child: Image.network(
          imageUrl,
        ),
      ),
    );
  }
}