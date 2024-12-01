
import 'package:flutter/material.dart';

class BubblePopPage extends StatelessWidget {
  const BubblePopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bubble Pop'),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.bubble_chart, size: 80, color: Colors.purpleAccent),
                SizedBox(height: 16),
                Text(
                  'Pop the bubbles to release stress! Each pop represents a calming breath.',
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
