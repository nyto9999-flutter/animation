import 'dart:math';

import 'package:flutter/material.dart';

import 'ball.dart';

class ParaCurveDemo extends StatefulWidget {
  const ParaCurveDemo({Key? key}) : super(key: key);

  @override
  State<ParaCurveDemo> createState() => _ParaCurveDemoState();
}

class _ParaCurveDemoState extends State<ParaCurveDemo> {
  final draggableBall = const Ball(color: Colors.red, radius: 50);
  final draggingBall = const Ball(color: Colors.yellow, radius: 50);
  final dragTarget = const Ball(color: Colors.green, radius: 50);

  double initX = 0;
  double initY = 500;
  late double endX;
  late double endY;

  bool isThrow = false;
  double appBarHeight = 56;

  ///[doubable]
  // function get theta by ballInitX and ballInitY, and ballX and ballY
  double getTheta(double x1, double y1, double x2, double y2) {
    double theta = atan((y2 - y1) / (x2 - x1));
    return theta;
  }

  List<List<double>> calculatePositions(
    double vx,
    double vy,
    double theta,
    double timeInterval,
  ) {
    const g = 9.8; // 重力加速度，單位 m/s^2
    List<List<double>> positions = [];

    double t = 0;
    while (true) {
      double x = vx * cos(theta) * t;
      double y = vy * sin(theta) * t - 0.5 * g * pow(t, 2);

      if (y < 0) {
        break;
      }

      positions.add([x, y]);

      t += timeInterval;
    }

    return positions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draggable Demo'),
      ),

      // screen
      body: Container(
        color: Colors.black,

        // object
        child: Stack(
          children: [
            //create animatedContainter with throwing ball curve

            Positioned(
              left: initX,
              top: initY,
              child: AnimatedContainer(
                duration: const Duration(seconds: 10),
                curve: Curves.easeOutCubic,
                child: Draggable(
                  data: 'hit the target',
                  feedback: draggingBall,
                  onDragStarted: () {
                    isThrow = false;
                  },
                  onDragEnd: (details) {
                    double dragEndX = details.offset.dx;
                    double dragEndY = details.offset.dy;
                    double vx = details.velocity.pixelsPerSecond.dx;
                    double vy = details.velocity.pixelsPerSecond.dy;
                    // get angle then calculate curve
                    final theta = getTheta(initX, initY, dragEndX, dragEndY);
                    print(theta);

                    // for (int i = 0; i < curve.length; i++) {
                    //   setState(() {
                    //     print(curve[i][0]);
                    //     ballX = curve[i][0];
                    //     ballY = curve[i][1];
                    //   });
                    // }
                  },
                  childWhenDragging: Container(),
                  child: draggableBall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
