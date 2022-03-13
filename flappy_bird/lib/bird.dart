import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  late final birdY;
  MyBird({required this.birdY});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'lib/images/flappy.png',
        height: 45,
        width: 45,
      ),
    );
  }
}
