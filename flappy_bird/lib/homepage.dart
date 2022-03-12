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
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  double velocity = 2.5;
  bool isGameRunning = false;

  static double barrierXone = 0;
  static double barrierXtwo = barrierXone + 1.5;
  double barrierXthree = barrierXtwo + 1.5;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    isGameRunning = true;
    Timer.periodic(
      const Duration(milliseconds: 60),
      (timer) {
        time += 0.04;
        height = -4.9 * time * time + velocity * time;
        setState(() {
          birdYaxis = initialHeight - height;
        });
        if (birdYaxis > 1) {
          timer.cancel();
          isGameRunning = false;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (isGameRunning) {
                        jump();
                      } else {
                        startGame();
                      }
                    },
                    child: AnimatedContainer(
                      alignment: Alignment(0, birdYaxis),
                      duration: const Duration(milliseconds: 0),
                      child: MyBird(),
                      color: Colors.blue,
                    ),
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
                      child: MyBarrier(size: 200.0)),
                  AnimatedContainer(
                      alignment: Alignment(barrierXtwo, -1.1),
                      duration: const Duration(milliseconds: 0),
                      child: MyBarrier(size: 200.0)),
                  AnimatedContainer(
                      alignment: Alignment(barrierXthree, 1.1),
                      duration: const Duration(milliseconds: 0),
                      child: MyBarrier(size: 200.0)),
                  AnimatedContainer(
                      alignment: Alignment(barrierXthree, -1.1),
                      duration: const Duration(milliseconds: 0),
                      child: MyBarrier(size: 200.0)),
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
    );
  }
}
