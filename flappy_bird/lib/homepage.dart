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
  static double birdY = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdY;
  double velocity = 2.5;
  bool isGameRunning = false;

  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1.5;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdY;
    });
  }

  bool birdIsDead() {
    if (birdY > 1 || birdY < -1) {
      return true;
    }
    return false;
  }

  void resetGame() {
    Navigator.pop(context); // dismisses the alert dialog
    setState(() {
      birdY = 0;
      isGameRunning = false;
      time = 0;
      initialHeight = birdY;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.green,
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
                  onTap: resetGame,
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

  void startGame() {
    isGameRunning = true;
    Timer.periodic(
      const Duration(milliseconds: 40),
      (timer) {
        time += 0.04;
        height = -4.9 * time * time + velocity * time;
        setState(() {
          birdY = initialHeight - height;
        });

        setState(() {
          if (barrierXone < -2) {
            barrierXone += 3.5;
          } else {
            barrierXone -= 0.05;
          }
        });

        setState(() {
          if (barrierXtwo < -2) {
            barrierXtwo += 3.5;
          } else {
            barrierXtwo -= 0.05;
          }
        });

        if (birdIsDead()) {
          timer.cancel();
          isGameRunning = false;
          _showDialog();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isGameRunning) {
          jump();
        } else {
          startGame();
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
                      ),
                      color: Colors.blue,
                    ),
                    Container(
                      alignment: const Alignment(0, -0.25),
                      child: isGameRunning
                          ? const Text(" ")
                          : const Text(
                              "T A P  T O  P L A Y",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                    ),
                    AnimatedContainer(
                        alignment: Alignment(barrierXone, 1.1),
                        duration: const Duration(milliseconds: 0),
                        child: MyBarrier(size: 200.0)),
                    AnimatedContainer(
                        alignment: Alignment(barrierXone, -1.1),
                        duration: const Duration(milliseconds: 0),
                        child: MyBarrier(size: 200.0)),
                    AnimatedContainer(
                        alignment: Alignment(barrierXtwo, 1.1),
                        duration: const Duration(milliseconds: 0),
                        child: MyBarrier(size: 150.0)),
                    AnimatedContainer(
                        alignment: Alignment(barrierXtwo, -1.1),
                        duration: const Duration(milliseconds: 0),
                        child: MyBarrier(size: 250.0)),
                  ],
                )),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
                child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Score",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '0',
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Best Score",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '10',
                        style: TextStyle(color: Colors.white, fontSize: 35),
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
