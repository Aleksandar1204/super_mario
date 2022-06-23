import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supermario/button.dart';
import 'package:supermario/jumping_mario.dart';
import 'package:supermario/mario.dart';
import 'package:supermario/mushroom.dart';

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
  double mushroomX = 0.5;
  double mushroomY = 1;
  double marioSize = 50;
  double time = 0;
  double height = 0;
  double initialHeight = marioY;
  String direction = "right";
  bool midRun = true;
  bool midJump = false;
  bool mushroomEat = false;
  var gameFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.white, fontSize: 20));

  void ateShrooms() {
    if ((marioX - mushroomX).abs() < 0.05 &&
        (marioY - mushroomY).abs() < 0.05) {
      setState(() {
        mushroomEat = true;
        marioSize = 100;
      });
    }
  }

  void preJump() {
    time = 0;
    initialHeight = marioY;
  }

  void jump() {
    if (midJump == false) {
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
  }

  void moveRight() {
    direction = "right";
    ateShrooms();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      ateShrooms();
      if (Button().holdingButtonPress() == true && (marioX + 0.04) < 1) {
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
    ateShrooms();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      ateShrooms();
      if (Button().holdingButtonPress() == true && (marioX - 0.04) > -1) {
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
                              size: marioSize,
                            )
                          : Mario(
                              direction: direction,
                              midRun: midRun,
                              size: marioSize,
                            )),
                ),
                Container(
                    alignment: Alignment(mushroomX, mushroomY),
                    child: mushroomEat == true ? Container() : Mushroom()),
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
                          SizedBox(
                            height: 10,
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
                          SizedBox(
                            height: 10,
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
                          SizedBox(
                            height: 10,
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
