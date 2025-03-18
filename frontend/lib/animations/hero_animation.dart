import 'package:flutter/material.dart';

class HeroAnimationWidget extends StatelessWidget {
  final String imagePath;
  final String tag;
  final Widget destinationScreen;

  const HeroAnimationWidget({
    required this.imagePath,
    required this.tag,
    required this.destinationScreen,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationScreen),
        );
      },
      child: Hero(
        tag: tag,
        child: Image.asset(imagePath, width: 150, height: 150),
      ),
    );
  }
}
