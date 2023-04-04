import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  final Color color;

  final double radius;
  final double size = 1111100;

  const Ball({
    super.key,
    required this.color,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(radius)),
    );
  }
}
//jlfkdsjflk