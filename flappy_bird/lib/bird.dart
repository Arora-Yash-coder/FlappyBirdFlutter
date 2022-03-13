import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  final double birdY;
  final double birdWidth;
  final double birdHeight;
  MyBird(
      {required this.birdY, required this.birdHeight, required this.birdWidth});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      alignment: Alignment(0, (2 * birdY + birdWidth) / (2 - birdHeight)),
      child: Image.asset(
        'lib/images/flappy.png',
        height: MediaQuery.of(context).size.width * birdWidth / 2,
        width: MediaQuery.of(context).size.height * 3 / 4 * birdWidth / 2,
        fit: BoxFit.fill,
      ),
    );
  }
}
