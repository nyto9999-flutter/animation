import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransformDemo extends StatefulWidget {
  const TransformDemo({super.key});

  @override
  State<TransformDemo> createState() => _TransformDemoState();
}

class _TransformDemoState extends State<TransformDemo>
    with TickerProviderStateMixin {
  final randon = Random().nextDouble();
  late final AnimationController _rotateContr;
  late final AnimationController translateContr;
  late final AnimationController scaleContr;
  late final AnimationController m4RotateContr;
  late final AnimationController skewContr;
  late final AnimationController perspectiveContr;

  @override
  void initState() {
    super.initState();
    final vsync = this;
    _rotateContr =
        AnimationController(duration: const Duration(seconds: 3), vsync: vsync);

    _rotateContr.repeat();
    translateContr =
        AnimationController(duration: const Duration(seconds: 3), vsync: vsync);
    translateContr.repeat();

    scaleContr =
        AnimationController(duration: const Duration(seconds: 3), vsync: vsync);
    scaleContr.repeat();

    m4RotateContr =
        AnimationController(duration: const Duration(seconds: 3), vsync: vsync);
    m4RotateContr.repeat();

    skewContr =
        AnimationController(duration: const Duration(seconds: 3), vsync: vsync);
    skewContr.repeat();

    perspectiveContr =
        AnimationController(duration: const Duration(seconds: 3), vsync: vsync);
    perspectiveContr.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Transform Demo'),
        ),
        body: Center(
          child: Row(
            children: [
              /// Translate
              ///
              AnimatedBuilder(
                animation: translateContr,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      translateContr.value * randon,
                      translateContr.value * 50 * randon,
                    ),
                    child: child,
                  );
                },
                child: Object(title: 'Trans', contr: translateContr),
              ),

              /// Rotate
              ///
              AnimatedBuilder(
                animation: _rotateContr,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: 2 * pi * _rotateContr.value,
                    child: child,
                  );
                },
                child: Object(title: 'Rotate', contr: _rotateContr),
              ),

              /// Scale
              ///
              AnimatedBuilder(
                animation: scaleContr,
                builder: (context, child) {
                  return Transform.scale(
                    scale: scaleContr.value,
                    child: child,
                  );
                },
                child: Object(title: 'Scale', contr: scaleContr),
              ),

              /// Matrix4
              ///
              AnimatedBuilder(
                animation: m4RotateContr,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..rotateX(pi * m4RotateContr.value),
                    // ..rotateY(pi * 1 * m4RotateContr.value)
                    // ..rotateZ(pi * 1 * m4RotateContr.value),
                    alignment: Alignment.center,
                    child: child,
                  );
                },
                child: Object(title: 'M4Rotate', contr: m4RotateContr),
              ),

              /// Skew
              ///
              AnimatedBuilder(
                animation: skewContr,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(0, 1, skewContr.value),
                    child: child,
                  );
                },
                child: Object(title: 'M4Skew', contr: skewContr),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _rotateContr.dispose();
    translateContr.dispose();
    scaleContr.dispose();
    super.dispose();
  }
}

class Object extends StatelessWidget {
  const Object({
    super.key,
    required this.title,
    required this.contr,
  });

  final AnimationController contr;
  final String title;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: CupertinoColors.systemRed,
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 40),
      ),
    );
  }
}
