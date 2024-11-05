import 'package:cc206_emoti_sense/features/dashboard.dart';
import 'package:flutter/material.dart';

Widget _buildCuratedItem(BuildContext context, String title, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: color.withOpacity(0.2),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 30),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    ),
  );
}

class MusicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Music'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Dashboard()),
              );
            },
          ),
        ),
        body: ListView(
          children: [
            _buildCuratedItem(context, 'Chill Beats', Icons.music_note, Colors.purpleAccent),
            _buildCuratedItem(context, 'Focus Tunes', Icons.headphones, Colors.blueAccent),
            _buildCuratedItem(context, 'Feel Good', Icons.audiotrack, Colors.orangeAccent),
          ],
        ),
    );
  }
}

