import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supermario/button.dart';
import 'package:supermario/coin.dart';
import 'package:supermario/coin_box.dart';
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
  double moneyBoxX = 0;
  double moneyBoxY = 0.3;
  double marioSize = 50;
  double coinX = 0;
  double coinY = 0;
  double time = 0;
  double height = 0;
  double initialHeight = marioY;
  String direction = "right";
  bool midRun = true;
  bool midJump = false;
  bool mushroomEat = false;
  bool touchBox = false;
  bool showCoin = false;
  int money = 0;
  var gameFont = GoogleFonts.pressStart2p(
      textStyle: const TextStyle(color: Colors.white, fontSize: 20));

  void ateShrooms() {
    if ((marioX - mushroomX).abs() < 0.05 &&
        (marioY - mushroomY).abs() < 0.05) {
      setState(() {
        mushroomEat = true;
        marioSize = 100;
      });
    }
  }

  void coinMove() {
    showCoin = true;

    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        coinY -= 0.04;
      });
      if (money % 10 == 0) {
        timer.cancel();
      }
      if (money % 10 != 0 && (marioX - moneyBoxX).abs() > 0.1) {
        showCoin = false;
        timer.cancel();
      }
    });
  }

  void catchMoneyBox() {
    if ((marioX - moneyBoxX).abs() < 0.1 && (marioY - moneyBoxY).abs() < 0.32) {
      coinMove();
      setState(() {
        money += 1;
      });
    }
  }

  void preJump() {
    time = 0;
    initialHeight = marioY;
  }

  void jump() {
    if (initialHeight == 1.16) {
      if (midJump == false) {
        midJump = true;
        preJump();
        Timer.periodic(const Duration(milliseconds: 50), (timer) {
          catchMoneyBox();
          time += 0.05;
          print(marioY - moneyBoxY);
          height =
              ((marioX - moneyBoxX).abs() < 0.1 && marioY - moneyBoxY > 0.3)
                  ? -15.9 * time * time + 5 * time
                  : mushroomEat == false
                      ? -4.9 * time * time + 5 * time
                      : mushroomEat == true
                          ? -3.9 * time * time + 5 * time
                          : 0;

          if (initialHeight - height > 1) {
            midJump = false;
            timer.cancel();

            setState(() {
              marioY = 1;
              coinY = 0;
            });
          } else {
            setState(() {
              marioY = initialHeight - height;
            });
          }
        });
      }
    }
    if (midJump == false) {
      midJump = true;

      preJump();

      Timer.periodic(const Duration(milliseconds: 50), (timer) {
        catchMoneyBox();
        time += 0.05;
        print(marioY - moneyBoxY);
        height = ((marioX - moneyBoxX).abs() < 0.1 && marioY - moneyBoxY > 0.3)
            ? -15.9 * time * time + 5 * time
            : mushroomEat == false
                ? -4.9 * time * time + 5 * time
                : mushroomEat == true
                    ? -3.9 * time * time + 5 * time
                    : 0;

        if ((marioX - moneyBoxX).abs() < 0.1 && marioY < -0.22) {
          setState(() {
            initialHeight = 1.16;
            midJump = false;
            timer.cancel();
          });
        }

        if (initialHeight - height > 1) {
          midJump = false;
          timer.cancel();

          setState(() {
            marioY = 1;
            coinY = 0;
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

    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if ((marioX - moneyBoxX).abs() > 0.12 && initialHeight == 1.16) {
        Timer.periodic(const Duration(milliseconds: 5), (timer) {
          setState(() {
            marioY += 0.004;
            if (marioY > 0.99) {
              initialHeight = 0;
              timer.cancel();
              return;
            }
          });
        });
      }

      ateShrooms();
      if (const Button().holdingButtonPress() == true && (marioX + 0.04) < 1) {
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
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      ateShrooms();
      if ((marioX - moneyBoxX).abs() > 0.12 && initialHeight == 1.16) {
        Timer.periodic(const Duration(milliseconds: 5), (timer) {
          setState(() {
            marioY += 0.004;
            if (marioY > 0.99) {
              initialHeight = 0;
              timer.cancel();
              return;
            }
          });
        });
      }
      if (const Button().holdingButtonPress() == true && (marioX - 0.04) > -1) {
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
                      duration: const Duration(milliseconds: 0),
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
                    child:
                        mushroomEat == true ? Container() : const Mushroom()),
                Container(
                  alignment: Alignment(moneyBoxX, moneyBoxY),
                  child: const CoinBox(),
                ),
                showCoin == true
                    ? Container(
                        alignment: Alignment(coinX, coinY),
                        child: const Coin(),
                      )
                    : Container(),
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
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            money.toString(),
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
                          const SizedBox(
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
                          const SizedBox(
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/images/bricks.png"),
                fit: BoxFit.cover,
              ),
            ),
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
