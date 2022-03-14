import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  // Position of Bird
  final double birdY;
  // Bird's Width
  final double birdWidth;
  // Bird's Height
  final double birdHeight;

  // Constructor
  MyBird(
      {required this.birdY, required this.birdHeight, required this.birdWidth});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      alignment: Alignment(0, (2 * birdY + birdWidth) / (2 - birdHeight)),
      height: MediaQuery.of(context).size.width * birdWidth / 2,
      width: MediaQuery.of(context).size.height * 3 / 4 * birdWidth / 2,
      child: Image.asset(
        'lib/images/flappy.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
