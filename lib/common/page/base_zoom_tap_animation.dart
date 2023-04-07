library zoom_tap_animation;

import 'dart:async';
import 'package:flutter/widgets.dart';

class BaseZoomTapAnimation extends StatefulWidget {
  final Widget child;
  final double begin, end;
  final Duration beginDuration, endDuration, longTapRepeatDuration;
  final Function()? onTap, onLongTap;
  final bool enableLongTapRepeatEvent;
  final Curve beginCurve, endCurve;
  final HitTestBehavior behavior;

  const BaseZoomTapAnimation(
      {Key? key,
      required this.child,
      this.onTap,
      this.begin = 1.0,
      this.end = 0.93,
      this.beginDuration = const Duration(milliseconds: 20),
      this.endDuration = const Duration(milliseconds: 120),
      this.longTapRepeatDuration = const Duration(milliseconds: 100),
      this.beginCurve = Curves.decelerate,
      this.endCurve = Curves.fastOutSlowIn,
      this.onLongTap,
      this.enableLongTapRepeatEvent = false,
      this.behavior = HitTestBehavior.deferToChild})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BaseZoomTapAnimationState();
}

class _BaseZoomTapAnimationState extends State<BaseZoomTapAnimation>
    with SingleTickerProviderStateMixin<BaseZoomTapAnimation> {
  AnimationController? _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: widget.endDuration,
        value: 1.0,
        reverseDuration: widget.beginDuration);
    _animation = Tween(begin: widget.end, end: widget.begin).animate(
        CurvedAnimation(
            parent: _controller!,
            curve: widget.beginCurve,
            reverseCurve: widget.endCurve));
    _controller?.forward();
  }

  bool _isOnTap = true;

  @override
  Widget build(BuildContext context) {
    Future<void> _onLongPress() async {
      await _controller?.forward();
      await widget.onLongTap?.call();
    }

    return GestureDetector(
      behavior: widget.behavior,
      onTap: widget.onTap,
      onLongPress: widget.onLongTap != null && !widget.enableLongTapRepeatEvent
          ? _onLongPress
          : null,
      child: Listener(
        behavior: widget.behavior,
        onPointerDown: (c) async {
          _isOnTap = true;
          _controller?.reverse();
          if (widget.enableLongTapRepeatEvent) {
            await Future.delayed(widget.longTapRepeatDuration);
            while (_isOnTap) {
              await Future.delayed(widget.longTapRepeatDuration, () async {
                await (widget.onLongTap ?? widget.onTap)?.call();
              });
            }
          }
        },
        onPointerUp: (c) async {
          _isOnTap = false;
          await _controller?.forward();
        },
        child: ScaleTransition(scale: _animation, child: widget.child),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.stop();
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }
}
