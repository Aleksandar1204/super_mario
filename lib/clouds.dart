import 'package:flutter/material.dart';

class Clouds extends StatelessWidget {
  const Clouds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: Image.asset('lib/images/cluds.png'),
    );
  }
}
