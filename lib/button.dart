import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final child;
  final function;
  const Button({Key? key, this.child, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: EdgeInsets.all(10),
          child: child,
          color: Colors.brown[300],
        ),
      ),
    );
  }
}
