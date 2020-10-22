import 'dart:math';

import 'package:flutter/material.dart';
import 'box.dart';
import 'obstacle.dart';
import 'settings.dart';

class GameEngine extends StatefulWidget {
  @override
  _GameEngineState createState() => _GameEngineState();
}

class _GameEngineState extends State<GameEngine>
    with SingleTickerProviderStateMixin {
  final b = Box();
  AnimationController _animationController;
  List<Obstacle> _obstacles = <Obstacle>[];

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animationController.addListener(_updateUI);
    _animationController.repeat();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateUI() {
    if (b != null) {
      setState(() {
        b.updatePosition();

        gameSpeed += 0.0003;
        spawnObstacle--;

        if (spawnObstacle <= 0) {
          _createObstacle();
        }

        _obstacles.forEach((i) {
          i.move();
        });
      });
    }
  }

  void _createObstacle() {
    final randomSpawnObstacle = _createRandomValue(50, 100);
    final random = _createRandomValue(20, 40);

    final obstacle = Obstacle(
      width: random,
      height: random,
      x: MediaQuery.of(context).size.width - random,
      y: mainHeight - random,
      dx: gameSpeed,
      color: Colors.yellow,
    );

    _obstacles.add(obstacle);
    spawnObstacle = randomSpawnObstacle;
  }

  double _createRandomValue(int min, int max) {
    final result = min + Random().nextInt(max - min);
    return result.toDouble();
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
                Stack(
                  children: _obstacles.map((i) => i.getObstacle).toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
