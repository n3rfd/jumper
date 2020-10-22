import 'package:flutter/material.dart';

class Obstacle {
  final double width;
  final double height;
  final double y;

  double x;
  double dx;

  final Color color;

  Obstacle({
    this.width,
    this.height,
    this.y,
    this.x,
    this.dx,
    this.color,
  });

  void move() {
    this.x -= this.dx;
  }

  Widget get getObstacle => Transform.translate(
        offset: Offset(x, y),
        child: Container(
          width: width,
          height: height,
          color: color,
        ),
      );
}
