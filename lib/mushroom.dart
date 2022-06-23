import 'package:flutter/material.dart';

class Mushroom extends StatelessWidget {
  const Mushroom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      child: Image.asset('lib/images/mushroom.png'),
    );
  }
}
