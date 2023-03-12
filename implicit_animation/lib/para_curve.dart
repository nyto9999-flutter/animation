import 'package:flutter/material.dart';

class ParaCurveDemo extends StatefulWidget {
  const ParaCurveDemo({super.key});

  @override
  State<ParaCurveDemo> createState() => _ParaCurveDemoState();
}

class _ParaCurveDemoState extends State<ParaCurveDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ParaCurve Demo'),
      ),
      body: const Center(
        child: Text('ParaCurve Demo'),
      ),
    );
  }
}
