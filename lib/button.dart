import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final child;
  const Button({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(10),
        child: child,
        color: Colors.brown[300],
      ),
    );
  }
}
