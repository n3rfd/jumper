import 'dart:ui';
import 'package:flutter/material.dart';

class Box {
  double _y = 125;

  Widget get getBox => Transform.translate(
        offset: Offset(10, _y),
        child: Container(
          width: 25,
          height: 25,
          color: Colors.red,
        ),
      );
}
