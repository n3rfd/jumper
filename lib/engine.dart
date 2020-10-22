import 'package:flutter/material.dart';
import 'package:jumper/box.dart';

class GameEngine extends StatefulWidget {
  @override
  _GameEngineState createState() => _GameEngineState();
}

class _GameEngineState extends State<GameEngine>
    with SingleTickerProviderStateMixin {
  final b = Box();
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animationController.addListener(_updateBoxPosition);
    _animationController.repeat();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateBoxPosition() {
    if (b != null) {
      setState(() {
        b.updatePosition();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          b.jump();
        },
        child: Center(
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
      ),
    );
  }
}
