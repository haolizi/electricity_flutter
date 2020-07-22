/*
 * -------详情页-------
 * Tabar不规则矩形
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeftPaintRoute extends StatelessWidget {
  final bool isLeft;
  const LeftPaintRoute({Key key, this.isLeft}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(ScreenUtil().setWidth(375), 40), // 指定画布大小
        painter: LeftPainter(isLeft: isLeft),
      ),
    );
  }
}

class LeftPainter extends CustomPainter {
  final bool isLeft;
  const LeftPainter({this.isLeft});
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
        Path()
          ..moveTo(0.0, 0.0)
          ..lineTo(0.0, 40.0)
          ..lineTo(ScreenUtil().setWidth(375), 40.0)
          ..lineTo(ScreenUtil().setWidth(340), 0.0)
          ..close(),
        Paint()
          ..color = this.isLeft ? Colors.white : Colors.transparent
          ..strokeWidth = 1.0
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class RightPaintRoute extends StatelessWidget {
  final bool isRight;
  const RightPaintRoute({Key key, this.isRight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(ScreenUtil().setWidth(375), 40), // 指定画布大小
        painter: RightPainter(isRight: isRight),
      ),
    );
  }
}

class RightPainter extends CustomPainter {
  final bool isRight;
  const RightPainter({this.isRight});
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
        Path()
          ..moveTo(ScreenUtil().setWidth(35), 0.0)
          ..lineTo(0, 40.0)
          ..lineTo(ScreenUtil().setWidth(375), 40.0)
          ..lineTo(ScreenUtil().setWidth(375), 0.0)
          ..close(),
        Paint()
          ..color = this.isRight ? Colors.white : Colors.transparent
          ..strokeWidth = 1.0
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
