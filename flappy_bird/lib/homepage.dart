import 'dart:async';

import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

import 'barriers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // bird positional variables
  static double birdY = 0;
  double birdHeight = 0.1;
  double birdWidth = 0.1;

  // bird movement variables
  double time = 0;
  double height = 0;
  double initialHeight = birdY;
  double velocity = 3.2;

  // scores
  int score = 0;
  int bestScore = 0;

  // game settings
  bool isGameRunning = false;

  // barrier variables
  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1.5;
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.5, 0.7],
    [0.6, 0.6],
  ];

  void _jump() {
    setState(() {
      time = 0;
      initialHeight = birdY;
    });
  }

  void _startGame() {
    isGameRunning = true;
    Timer.periodic(
      const Duration(milliseconds: 16),
      (timer) {
        time += 0.014;
        height = -4.9 * time * time + velocity * time;
        setState(() {
          birdY = initialHeight - height;
        });

        setState(() {
          if (barrierXone < -2) {
            barrierXone += 3.5;
            score++;
          } else {
            barrierXone -= 0.025;
          }
        });

        setState(() {
          if (barrierXtwo < -2) {
            barrierXtwo += 3.5;
            score++;
          } else {
            barrierXtwo -= 0.025;
          }
        });

        if (_birdIsDead()) {
          timer.cancel();
          isGameRunning = false;
          _showDialog();
        }
      },
    );
  }

  bool _birdIsDead() {
    if (score > bestScore) {
      bestScore = score;
    }
    if (birdY > 1 || birdY < -1) {
      return true;
    }
    if (barrierXone <= birdWidth &&
        barrierXone + barrierWidth >= -birdWidth &&
        (birdY <= -1.04 + barrierHeight[0][0] ||
            birdY + birdHeight >= 1.1 - barrierHeight[0][1])) {
      return true;
    }
    if (barrierXtwo <= birdWidth &&
        barrierXtwo + barrierWidth >= -birdWidth &&
        (birdY <= -1.04 + barrierHeight[1][0] ||
            birdY + birdHeight >= 1.1 - barrierHeight[1][1])) {
      return true;
    }

    return false;
  }

  void _resetGame() {
    Navigator.pop(context); // dismisses the alert dialog
    setState(() {
      birdY = 0;
      isGameRunning = false;
      time = 0;
      initialHeight = birdY;
      barrierXone = 1;
      barrierXtwo = barrierXone + 1.5;
      score = 0;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Center(
              child: Text(
                "G A M E  O V E R",
                style: TextStyle(color: Colors.white),
              ), // Text
            ), // Center
            actions: [
              Center(
                child: GestureDetector(
                  onTap: _resetGame,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      color: Colors.white,
                      child: const Text(
                        "PLAY AGAIN",
                        style: TextStyle(color: Colors.green),
                      ), // Text
                    ), // Container
                  ), // ClipRRect
                ),
              ) // GestureDetector
            ],
          ); // AlertDialog
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isGameRunning) {
          _jump();
        } else {
          _startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0, birdY),
                      duration: const Duration(milliseconds: 0),
                      child: MyBird(
                        birdY: birdY,
                        birdWidth: birdWidth,
                        birdHeight: birdHeight,
                      ),
                      color: Colors.blue,
                    ),
                    Container(
                      alignment: const Alignment(0, -0.25),
                      child: Text(
                        isGameRunning ? "" : "T A P  T O  P L A Y",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    AnimatedContainer(
                        duration: const Duration(milliseconds: 0),
                        child: MyBarrier(
                          isBottomBarrier: false,
                          barrierHeight: barrierHeight[0][0],
                          barrierWidth: barrierWidth,
                          barrierX: barrierXone,
                        )),
                    AnimatedContainer(
                        duration: const Duration(milliseconds: 0),
                        child: MyBarrier(
                          isBottomBarrier: true,
                          barrierHeight: barrierHeight[0][1],
                          barrierWidth: barrierWidth,
                          barrierX: barrierXone,
                        )),
                    AnimatedContainer(
                        duration: const Duration(milliseconds: 0),
                        child: MyBarrier(
                          isBottomBarrier: false,
                          barrierHeight: barrierHeight[1][0],
                          barrierWidth: barrierWidth,
                          barrierX: barrierXtwo,
                        )),
                    AnimatedContainer(
                        duration: const Duration(milliseconds: 0),
                        child: MyBarrier(
                          isBottomBarrier: true,
                          barrierHeight: barrierHeight[1][1],
                          barrierWidth: barrierWidth,
                          barrierX: barrierXtwo,
                        )),
                  ],
                )),

            // Grass Area
            Container(
              height: 15,
              color: Colors.green,
            ),

            //Ground Area
            Expanded(
                child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Score",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        score.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 35),
                      )
                    ],
                  ),

                  // Best Score Widget
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Best Score",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        bestScore.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 35),
                      )
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
