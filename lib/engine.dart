import 'package:flutter/material.dart';
import 'package:jumper/box.dart';

class GameEngine extends StatefulWidget {
  @override
  _GameEngineState createState() => _GameEngineState();
}

class _GameEngineState extends State<GameEngine> {
  final b = Box();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: 150,
          color: Colors.grey,
          child: Stack(
            children: <Widget>[
              b.getBox,
            ],
          ),
        ),
      ),
    );
  }
}
