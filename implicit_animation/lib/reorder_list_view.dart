import 'package:flutter/material.dart';

class ReorderListView extends StatefulWidget {
  const ReorderListView({super.key});

  @override
  State<ReorderListView> createState() => _ReorderListViewState();
}

class _ReorderListViewState extends State<ReorderListView> {
  final children = [
    Draggable(
      key: const ValueKey(1),
      feedback: const Icon(Icons.ac_unit, size: 50),
      childWhenDragging: Container(
        height: 50,
        width: 50,
        color: Colors.blue.withOpacity(0.5),
      ),
      onDraggableCanceled: (Velocity velocity, Offset offset) {},
      feedbackOffset: Offset.zero,
      maxSimultaneousDrags: 1,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      child: const Icon(Icons.ac_unit, size: 50),
    ),
    Draggable(
      key: const ValueKey(2),
      feedback: const Icon(Icons.stacked_bar_chart, size: 50),
      childWhenDragging: Container(
        height: 50,
        width: 50,
        color: Colors.blue.withOpacity(0.5),
      ),
      onDraggableCanceled: (Velocity velocity, Offset offset) {},
      feedbackOffset: Offset.zero,
      maxSimultaneousDrags: 1,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      child: const Icon(Icons.stacked_bar_chart, size: 50),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReorderableListView'),
      ),
      drawer: Drawer(
        width: 150,
        child: ReorderableListView(
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final item = children.removeAt(oldIndex);
              children.insert(newIndex, item);
            });
          },
          children: children,
        ),
      ),
      body: const Center(
        child: Text('ReorderableListView'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
      ),
    );
  }
}
