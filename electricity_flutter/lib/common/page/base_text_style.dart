import 'package:flutter/cupertino.dart';

import '../utils/color.dart';

class BaseTextWidget extends StatelessWidget {
  const BaseTextWidget(this.text, {Key? key, this.style})
      : super(key: key);
  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? baseTextStyle(),
    );
  }
}

TextStyle baseTextStyle({
  double? fontSize = 15,
  FontWeight? fontWeight = FontWeight.w400,
  Color? color = AppColors.primaryTitleColor31,
  Color? decorationColor,
  String? fontFamily,
  TextDecoration? decoration,
  double? height,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    fontFamily: fontFamily,
    height: height,
    decoration: decoration,
    decorationColor: decorationColor,
    overflow: TextOverflow.ellipsis,
  );
}
