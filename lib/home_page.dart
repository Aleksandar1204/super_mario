import 'package:flutter/material.dart';
import 'package:supermario/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                color: Colors.blue,
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