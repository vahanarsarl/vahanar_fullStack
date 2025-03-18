import 'package:flutter/material.dart';

class ListAnimation extends StatelessWidget {
  final int index;
  final Widget child;

  const ListAnimation({required this.index, required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 300 + (index * 100)),
      builder: (context, double opacity, child) {
        return Opacity(opacity: opacity, child: child);
      },
      child: child,
    );
  }
}
