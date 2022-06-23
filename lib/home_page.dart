import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supermario/button.dart';
import 'package:supermario/jumping_mario.dart';
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
  String direction = "right";
  bool midRun = true;
  bool midJump = false;
  var gameFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.white, fontSize: 20));

  void preJump() {
    time = 0;
    initialHeight = marioY;
  }

  void jump() {
    midJump = true;
    preJump();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 5 * time;
      if (initialHeight - height > 1) {
        midJump = false;
        timer.cancel();
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
    direction = "right";

    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (Button().holdingButtonPress() == true) {
        setState(() {
          marioX += 0.04;
          midRun = !midRun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void moveLeft() {
    direction = "left";

    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (Button().holdingButtonPress() == true) {
        setState(() {
          marioX -= 0.04;
          midRun = !midRun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Stack(children: [
                Container(
                  color: Colors.blue,
                  child: AnimatedContainer(
                      duration: Duration(milliseconds: 0),
                      alignment: Alignment(marioX, marioY),
                      child: midJump
                          ? JumpingMario(
                              direction: direction,
                            )
                          : Mario(
                              direction: direction,
                              midRun: midRun,
                            )),
                ),
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "MARIO",
                            style: gameFont,
                          ),
                          Text(
                            "0000",
                            style: gameFont,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "WORLD",
                            style: gameFont,
                          ),
                          Text(
                            "1-1",
                            style: gameFont,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "TIME",
                            style: gameFont,
                          ),
                          Text(
                            "00:00",
                            style: gameFont,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ])),
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
