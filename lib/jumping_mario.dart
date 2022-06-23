import 'dart:math';

import 'package:flutter/material.dart';

class JumpingMario extends StatelessWidget {
  final direction;
  const JumpingMario({Key? key, this.direction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (direction == "right") {
      return Container(
          width: 50,
          height: 50,
          child: Image.asset('lib/images/jumping_mario.png'));
    } else {
      return Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi),
          child: Container(
              width: 50,
              height: 50,
              child: Image.asset('lib/images/jumping_mario.png')));
    }
  }
}
