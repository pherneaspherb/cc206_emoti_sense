import 'package:flutter/material.dart';
import 'package:cc206_emoti_sense/features/discover_sections/music.dart';
import 'package:cc206_emoti_sense/features/discover_sections/meditation.dart'; 
import 'package:cc206_emoti_sense/features/discover_sections/breathwork.dart';
import 'package:cc206_emoti_sense/features/discover_sections/stories.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: 4, // We have 4 categories
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return _buildCategoryItem(context, 'Music', Icons.music_note, Colors.purpleAccent, MusicPage());
            case 1:
              return _buildCategoryItem(context, 'Meditation', Icons.self_improvement, Colors.greenAccent, const MeditationPage());
            case 2:
              return _buildCategoryItem(context, 'Breathwork', Icons.air, Colors.lightBlueAccent, BreathworkPage());
            case 3:
              return _buildCategoryItem(context, 'Stories', Icons.book, Colors.redAccent, PoemsPage());
            default:
              return Container(); // Empty container for any undefined index
          }
        },
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, String title, IconData icon, Color color, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        color: color.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 50),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
