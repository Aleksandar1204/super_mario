import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supermario/button.dart';
import 'package:supermario/mario.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  static double marioX = 0;
  static double marioY = 1;
  double time = 0;
  double height = 0;
  double initialHeight = marioY;

  void preJump() {
    time = 0;
    initialHeight = marioY;
  }

  void jump() {
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 5 * time;
      if (initialHeight - height > 1) {
        setState(() {
          marioY = 1;
        });
      } else {
        setState(() {
          marioY = initialHeight - height;
        });
      }
    });
  }

  void moveRight() {
    setState(() {
      marioX += 0.04;
    });
  }

  void moveLeft() {
    setState(() {
      marioX -= 0.04;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                color: Colors.blue,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 0),
                  alignment: Alignment(marioX, marioY),
                  child: Mario(),
                ),
              )),
          Expanded(
              child: Container(
            color: Colors.brown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Button(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  function: moveLeft,
                ),
                Button(
                  child: Icon(Icons.arrow_upward, color: Colors.white),
                  function: jump,
                ),
                Button(
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                  function: moveRight,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
