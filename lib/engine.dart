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
  bool _gameIsStart = false;
  int _score = 0;

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

  void _gameOver() async {
    _gameIsStart = false;
    _obstacles = [];
    gameSpeed = initGameSpeed;
    spawnObstacle = initSpawnObstacle;
  }

  void _updateUI() {
    if (b != null) {
      setState(() {
        b.updatePosition();

        if (_gameIsStart) {
          gameSpeed += 0.0003;
          spawnObstacle--;
          _score++;

          if (spawnObstacle <= 0) {
            _createObstacle();
          }

          _obstacles.forEach((i) {
            i.move();

            if (b.width + b.x >= i.x &&
                b.x <= i.x + i.width &&
                b.y + b.height >= i.y &&
                b.y <= i.y + i.height) {
              _gameOver();
            }
          });
        }
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
    return Stack(
      children: <Widget>[
        Scaffold(
          body: GestureDetector(
              onTap: () {
                b.jump();
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Text(
                      'Your Score : ' + _score.toString(),
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      color: Colors.grey,
                      child: Stack(
                        children: <Widget>[
                          b.getBox,
                          Stack(
                            children:
                                _obstacles.map((i) => i.getObstacle).toList(),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
        if (!_gameIsStart)
          Opacity(
            opacity: .6,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.black54,
            ),
          ),
        if (!_gameIsStart)
          Center(
            child: FlatButton(
              onPressed: () {
                _score = 0;
                _gameIsStart = true;
              },
              child: Text(
                'Press me start',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
