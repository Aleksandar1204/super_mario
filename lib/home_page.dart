import 'package:flutter/material.dart';
import 'package:supermario/button.dart';
import 'package:supermario/mario.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  double marioX = 0;
  double marioY = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                color: Colors.blue,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 0),
                  alignment: Alignment(marioX, marioY),
                  child: Mario(),
                ),
              )),
          Expanded(
              child: Container(
            color: Colors.brown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Button(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                Button(
                  child: Icon(Icons.arrow_upward, color: Colors.white),
                ),
                Button(
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
