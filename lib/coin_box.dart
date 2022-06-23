import 'package:flutter/material.dart';

class CoinBox extends StatelessWidget {
  const CoinBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.brown,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        height: 60,
        width: 60,
        child: Icon(
          Icons.question_mark,
          color: Colors.white,
        ));
  }
}
