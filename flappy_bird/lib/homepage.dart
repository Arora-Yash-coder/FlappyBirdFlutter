import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double birdYaxis = 0;
  void jump() {
    setState(() {
      birdYaxis = -0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: jump,
                child: AnimatedContainer(
                  alignment: Alignment(0, birdYaxis),
                  duration: Duration(milliseconds: 0),
                  child: MyBird(),
                  color: Colors.blue,
                ),
              )),
          Expanded(
              child: Container(
            color: Colors.green,
          ))
        ],
      ),
    );
  }
}
