import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  String _selectedItemMessage = '';

  void _onItemTap(String itemName) {
    setState(() {
      _selectedItemMessage = 'You selected: $itemName';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          _buildSectionTitle('Music'),
          _buildCuratedItem(context, 'Chill Beats', Icons.music_note, Colors.purpleAccent),
          _buildCuratedItem(context, 'Focus Tunes', Icons.headphones, Colors.blueAccent),
          _buildCuratedItem(context, 'Feel Good', Icons.audiotrack, Colors.orangeAccent),
          const SizedBox(height: 16.0),
          _buildSectionTitle ('Meditation'),
          _buildCuratedItem(context, 'Mindfulness', Icons.self_improvement, Colors.greenAccent),
          _buildCuratedItem(context, 'Sleep Meditation', Icons.nightlight_round, Colors.indigoAccent),
          _buildCuratedItem(context, 'Anxiety Relief', Icons.spa, Colors.teal),
          const SizedBox(height: 16.0),
          _buildSectionTitle('Breathwork'),
          _buildCuratedItem(context, 'Deep Breathing', Icons.air, Colors.lightBlueAccent),
          _buildCuratedItem(context, '4-7-8 Breathing', Icons.slow_motion_video, Colors.cyanAccent),
          _buildCuratedItem(context, 'Box Breathing', Icons.crop_square, Colors.blueGrey),
          const SizedBox(height: 16.0),
          _buildSectionTitle('Stories'),
          _buildCuratedItem(context, 'Inspiring Tales', Icons.book, Colors.redAccent),
          _buildCuratedItem(context, 'Bedtime Stories', Icons.bedtime, Colors.deepPurpleAccent),
          _buildCuratedItem(context, 'Life Lessons', Icons.menu_book, Colors.pinkAccent),
          const SizedBox(height: 16.0),
          // Message displayed when an item is selected
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _selectedItemMessage,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildCuratedItem(BuildContext context, String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () => _onItemTap(title),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
