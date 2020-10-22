import 'package:flutter/material.dart';

class GameEngine extends StatefulWidget {
  @override
  _GameEngineState createState() => _GameEngineState();
}

class _GameEngineState extends State<GameEngine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: 150,
          color: Colors.grey,
        ),
      ),
    );
  }
}
