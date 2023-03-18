import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ball.dart';

class ParaCurveDemo extends StatefulWidget {
  const ParaCurveDemo({Key? key}) : super(key: key);

  @override
  State<ParaCurveDemo> createState() => _ParaCurveDemoState();
}

///[TODO: Boundary bug]
class _ParaCurveDemoState extends State<ParaCurveDemo>
    with TickerProviderStateMixin {
  final draggableBall =
      const Ball(color: CupertinoColors.systemTeal, radius: 50);
  final draggingBall =
      const Ball(color: CupertinoColors.systemTeal, radius: 50);
  final GlobalKey _globalKey = GlobalKey();

  late AnimationController animationController;

  double initX = 0;
  late double initY = appBarHeight;
  late double endX = 0;
  late double endY = 0;
  double speed = 0.001;
  final velocity = 100;
  var repositionedXY = [0.0, 0.0];

  bool isAnimating = false;
  double appBarHeight = 56;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.initState();
    print('initState');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<double> reposition(double x, double y) {
      double newX = x;
      double newY = y;
      if (x > size.width) {
        newX = size.width;
      }

      if (y > size.height) {
        newY = size.height;
      }

      return [newX, newY];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Draggable Demo'),
      ),

      // screen
      body: Container(
        color: CupertinoColors.black,

        // object
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Positioned(
                  left: isAnimating ? endX : initX,
                  top: isAnimating ? endY - appBarHeight : initY - appBarHeight,
                  child: Draggable(
                    feedback: draggingBall,
                    onDragEnd: (details) {
                      double dragEndX = details.offset.dx;
                      double dragEndY = details.offset.dy;
                      double vx = details.velocity.pixelsPerSecond.dx;
                      double vy = details.velocity.pixelsPerSecond.dy;

                      if (vx.abs() < velocity && vy.abs() < velocity) {
                        isAnimating = false;
                        return;
                      }

                      endX = dragEndX * vx * speed;
                      print(endX);
                      print(endY);
                      endY = (dragEndY - appBarHeight) * vy * speed;

                      repositionedXY = reposition(endX, endY);

                      animationController.forward().whenCompleteOrCancel(() {
                        isAnimating = false;

                        ///get correct position after animation
                        ///
                        final RenderBox renderBox = _globalKey.currentContext
                            ?.findRenderObject() as RenderBox;
                        final position = renderBox.localToGlobal(Offset(
                          animationController.value * repositionedXY[0],
                          animationController.value * repositionedXY[1],
                        ));

                        ///reset ball's position
                        setState(() {
                          initX = position.dx;
                          initY = position.dy;
                        });
                        //get transform matrix please help me
                        animationController.reset();
                      });
                    },
                    child: isAnimating
                        ? draggableBall
                        : RepaintBoundary(
                            key: _globalKey,
                            child: Transform.translate(
                              filterQuality: FilterQuality.high,
                              offset: Offset(
                                  animationController.value * repositionedXY[0],
                                  animationController.value *
                                      repositionedXY[1]),
                              child: draggableBall,
                            ),
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
