import 'package:flutter/material.dart';

class SlideAnimation extends StatelessWidget {
  final Widget child;
  final double offsetX;
  final double offsetY;
  final double delay;

  const SlideAnimation({
    required this.child,
    this.offsetX = 0,
    this.offsetY = 50,
    this.delay = 0.5,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: Offset(offsetX, offsetY), end: Offset(0, 0)),
      duration: Duration(milliseconds: (delay * 1000).toInt()),
      builder: (context, Offset offset, child) {
        return Transform.translate(offset: offset, child: child);
      },
      child: child,
    );
  }
}
