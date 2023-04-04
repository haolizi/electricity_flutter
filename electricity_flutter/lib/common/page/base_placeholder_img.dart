import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BaseCachedNetworkImage extends StatelessWidget {
  final String url;
  final double? w;
  final double? h;
  final String defImagePath;
  final BoxFit fill;
  final GestureTapCallback? onTap;

  const BaseCachedNetworkImage({
    Key? key,
    required this.url,
    this.w,
    this.h,
    this.defImagePath = 'images/category_placehold.png',
    this.fill = BoxFit.fill,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return Image.asset(defImagePath);
    }

    return GestureDetector(
      onTap: onTap,
      child: CachedNetworkImage(
        imageUrl: url,
        fit: fill,
        width: w,
        height: h,
        placeholder: (_, __) => Image.asset(defImagePath),
      ),
    );
  }
}
