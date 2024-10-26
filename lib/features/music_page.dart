// music_page.dart
import 'package:flutter/material.dart';
import 'chill_beats_page.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Music'),
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Music', screenWidth),
            _buildCuratedGrid(
              [
                _buildCuratedItem(context, 'Chill Beats', Icons.music_note, Colors.purpleAccent),
                _buildCuratedItem(context, 'Focus Tunes', Icons.headphones, Colors.blueAccent),
                _buildCuratedItem(context, 'Feel Good', Icons.audiotrack, Colors.orangeAccent),
              ],
              screenWidth,
              screenHeight,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth * 0.06,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildCuratedGrid(List<Widget> items, double screenWidth, double screenHeight) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: screenWidth * 0.04,
      mainAxisSpacing: screenHeight * 0.02,
      childAspectRatio: 1.5,
      children: items,
    );
  }

  Widget _buildCuratedItem(BuildContext context, String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        if (title == 'Chill Beats') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChillBeatsPage(),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
