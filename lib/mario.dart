import 'dart:math';

import 'package:flutter/material.dart';

class Mario extends StatelessWidget {
  final direction;
  final midRun;
  const Mario({Key? key, this.direction, this.midRun}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (direction == "right") {
      return Container(
          width: 50,
          height: 50,
          child: midRun
              ? Image.asset('lib/images/standing_mario.png')
              : Image.asset('lib/images/running_mario.png'));
    } else {
      return Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi),
          child: Container(
              width: 50,
              height: 50,
              child: midRun
                  ? Image.asset('lib/images/standing_mario.png')
                  : Image.asset('lib/images/running_mario.png')));
    }
  }
}
