import 'package:flutter/material.dart';
import 'ball.dart';

class ParaCurveDemo extends StatefulWidget {
  const ParaCurveDemo({Key? key}) : super(key: key);

  @override
  State<ParaCurveDemo> createState() => _ParaCurveDemoState();
}

class _ParaCurveDemoState extends State<ParaCurveDemo>
    with TickerProviderStateMixin {
  final draggableBall = const Ball(color: Colors.red, radius: 50);
  final draggingBall = const Ball(color: Colors.yellow, radius: 50);

  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )..forward();

  double initX = 0;
  late double initY = appBarHeight;
  late double endX = 0;
  late double endY = appBarHeight;

  bool isAnimation = false;
  double appBarHeight = 56;

  @override
  void initState() {
    super.initState();
    print('initState');
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
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Positioned(
                  left: isAnimation ? endX : initX,
                  top: isAnimation ? endY - appBarHeight : initY - appBarHeight,
                  child: Draggable(
                    feedback: draggingBall,
                    onDragEnd: (details) {
                      double dragEndX = details.offset.dx;
                      double dragEndY = details.offset.dy;
                      double vx = details.velocity.pixelsPerSecond.dx;
                      double vy = details.velocity.pixelsPerSecond.dy;
                      //SPEED INCREASES WITH BY VELOCITY
                      double speed = 0.1;
                      endX = dragEndX + vx * speed;
                      endY = dragEndY + vy * speed;

                      animationController.forward().whenCompleteOrCancel(() {
                        print('whenCompleteOrCancel');
                        isAnimation = false;
                        print(animationController.value);
                        animationController.reset();
                      });
                    },
                    child: isAnimation
                        ? draggableBall
                        : Transform.translate(
                            offset: Offset(
                                animationController.value * endX,
                                animationController.value *
                                    (endY - appBarHeight)),
                            child: draggableBall,
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
