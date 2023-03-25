import 'package:flutter/material.dart';
import 'package:implicit_animation/drag_drop.dart';
import 'package:implicit_animation/para_curve.dart';
import 'package:implicit_animation/reorder_list_view.dart';
import 'package:implicit_animation/transform_demo.dart';

const pages = [
  DragDropDemo(),
  ParaCurveDemo(),
  TransformDemo(),
  ReorderListView()
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Animations',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Implicit Animation'),
          ),
          body: ListView.builder(
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => pages[index]));
                  },
                  title: Text(pages[index].toString()),
                );
              }),
        ));
  }
}
