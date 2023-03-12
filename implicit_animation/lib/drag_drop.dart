import 'package:flutter/material.dart';

class DragDropDemo extends StatefulWidget {
  const DragDropDemo({Key? key}) : super(key: key);

  @override
  State<DragDropDemo> createState() => _DragDropDemoState();
}

class _DragDropDemoState extends State<DragDropDemo> {
  final Color _color = Colors.red;

  final double _radius = 50;
  late double x = 0;
  late double y = 0;
  bool isHit = false;

  @override
  Widget build(BuildContext context) {
    GlobalKey key = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draggable Demo'),
      ),

      // screen
      body: Container(
        alignment: Alignment.center,
        color: Colors.black,

        // object
        child: Stack(
          children: [
            Positioned(
              left: x,
              top: y,
              child: Draggable(
                data: 'hit',
                feedback: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(_radius)),
                ),
                onDragEnd: (details) {
                  double centerX = details.offset.dx;
                  double centerY = details.offset.dy;
                  setState(() {
                    if (isHit) {
                      x = 0;
                      y = 0;
                      isHit = false;
                    } else {
                      x = centerX;
                      y = centerY - 56; //appbar height
                    }
                  });
                },
                childWhenDragging: Container(),
                key: key,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: _color,
                      borderRadius: BorderRadius.circular(_radius)),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 300,

              // target
              child: DragTarget(
                onAccept: (data) {
                  print(data);
                  isHit = true;
                },
                builder: (BuildContext context, List<Object?> candidateData,
                    List<dynamic> rejectedData) {
                  return Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(_radius)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
