import 'package:flutter/material.dart';

class Mario extends StatelessWidget {
  const Mario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: Image.asset('lib/images/standing_mario'),
    );
  }
}
