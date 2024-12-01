
import 'package:flutter/material.dart';

class MindfulnessMazePage extends StatelessWidget {
  const MindfulnessMazePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mindfulness Maze'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.map, size: 80, color: Colors.greenAccent),
                SizedBox(height: 16),
                Text(
                  'Navigate the maze mindfully, finding moments of calm and focus along the way.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
