
import 'package:flutter/material.dart';

class MoodMatchingGamePage extends StatelessWidget {
  const MoodMatchingGamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Matching Game'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.tag_faces, size: 80, color: Colors.blueAccent),
                SizedBox(height: 16),
                Text(
                  'Match the moods with their corresponding expressions to boost emotional awareness.',
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
