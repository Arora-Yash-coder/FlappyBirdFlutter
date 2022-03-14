import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  // Barrier's Width
  final double barrierWidth;
  // Barrier's Height
  final double barrierHeight;
  // Barrier's Position on X axis
  final double barrierX;
  // Barrier's Position [Top or Bottom]
  final bool isBottomBarrier;

  // Constructor
  MyBarrier(
      {required this.barrierX,
      required this.barrierHeight,
      required this.barrierWidth,
      required this.isBottomBarrier});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * barrierX + barrierWidth) / (2 - barrierWidth),
          isBottomBarrier ? 1.1 : -1.1),
      child: Container(
        width: MediaQuery.of(context).size.width * barrierWidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * barrierHeight / 2,
        decoration: BoxDecoration(
            color: Colors.green,
            border: Border.all(width: 10, color: Colors.green.shade800),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
