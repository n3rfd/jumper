import 'dart:ui';
import 'package:flutter/material.dart';

class Box {
  double y = 0;
  double _dy = 0;
  double _jumpForce = 15.0;
  double height = 25;
  bool _canJump = true;

  void updatePosition() {
    y += _dy;

    if (height + y < 150) {
      _dy += 1.0;
      _canJump = false;
    } else {
      _canJump = true;
      _dy = 0;
      y = 150 - height;
    }
  }

  void jump() {
    if (_canJump) {
      _dy -= _jumpForce;
    }
  }

  Widget get getBox => Transform.translate(
        offset: Offset(10, y),
        child: Container(
          width: 25,
          height: 25,
          color: Colors.red,
        ),
      );
}
