import 'package:flutter/material.dart';
import 'package:cc206_emoti_sense/features/discover_sections/music.dart';
import 'package:cc206_emoti_sense/features/discover_sections/meditation.dart'; 
import 'package:cc206_emoti_sense/features/discover_sections/breathwork.dart';
import 'package:cc206_emoti_sense/features/discover_sections/readings.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF003366), // Deep blue
              Color(0xFF006699), // Lighter deep blue
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: GridView.builder(
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
                return _buildCategoryItem(context, 'Music', Icons.music_note, const Color.fromARGB(255, 186, 104, 200), const Color.fromARGB(255, 225, 190, 231), const MusicPage());
              case 1:
                return _buildCategoryItem(context, 'Meditation', Icons.self_improvement, const Color.fromARGB(255, 247, 234, 117), Colors.amber, const MeditationPage());
              case 2:
                return _buildCategoryItem(context, 'Breathwork', Icons.air, Colors.green, const Color.fromARGB(255, 172, 236, 99), const BreathworkPage());
              case 3:
                return _buildCategoryItem(context, 'Readings', Icons.book, Colors.pink, const Color.fromARGB(255, 247, 148, 181), const ReadingsPage());
              default:
                return Container(); // Empty container for any undefined index
            }
          },
        ),
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, String title, IconData icon, Color color1, Color color2, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.topCenter, // Darker color starts at the top center
              end: Alignment.bottomCenter, // Lighter color ends at the bottom center
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: const Color.fromARGB(255, 255, 255, 255), size: 50),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
