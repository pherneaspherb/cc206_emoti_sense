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

class StoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Stories'),
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
            _buildCuratedItem(context, 'Inspiring Tales', Icons.book, Colors.redAccent),
            _buildCuratedItem(context, 'Motivational Moments', Icons.menu_book, Colors.orangeAccent),
            _buildCuratedItem(context, 'Bedtime Stories', Icons.nights_stay, Colors.indigoAccent),
          ],
        ),
    );
  }
}
