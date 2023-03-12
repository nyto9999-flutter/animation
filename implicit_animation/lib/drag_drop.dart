import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DragDropDemo extends StatefulWidget {
  const DragDropDemo({Key? key}) : super(key: key);

  @override
  State<DragDropDemo> createState() => _DragDropDemoState();
}

class _DragDropDemoState extends State<DragDropDemo> {
  final draggableBall = const Ball(color: Colors.red, radius: 50);
  final draggingBall = const Ball(color: Colors.yellow, radius: 50);
  final dragTarget = const Ball(color: Colors.green, radius: 50);
  double ballX = 0;
  double ballY = 0;
  bool isHit = false;
  double appBarHeight = 56;

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
            Positioned(
              left: ballX,
              top: ballY,
              child: Draggable(
                data: 'hit the target',
                feedback: draggingBall,
                onDragEnd: (details) {
                  double centerX = details.offset.dx;
                  double centerY = details.offset.dy;
                  setState(() {
                    if (isHit) {
                      ballX = 0;
                      ballY = 0;
                      isHit = false;
                    } else {
                      ballX = centerX;
                      ballY = centerY - appBarHeight; //appbar height
                    }
                  });
                },
                childWhenDragging: Container(),
                child: draggableBall,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 300,

              // target
              child: DragTarget(
                onAccept: (data) {
                  if (kDebugMode) {
                    print('Hit the target: $data');
                  }
                  isHit = true;
                },
                builder: (BuildContext context, List<Object?> candidateData,
                    List<dynamic> rejectedData) {
                  return dragTarget;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Ball extends StatelessWidget {
  final Color color;

  final double radius;
  final double size = 100;

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
