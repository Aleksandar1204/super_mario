import 'package:flutter/material.dart';

class Coin extends StatelessWidget {
  const Coin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      child: Image.asset('lib/images/coin.png'),
    );
  }
}
