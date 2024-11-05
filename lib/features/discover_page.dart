import 'package:flutter/material.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
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
            SizedBox(height: screenHeight * 0.03),
            _buildSectionTitle('Meditation', screenWidth),
            _buildCuratedGrid(
              [
                _buildCuratedItem(context, 'Mindfulness', Icons.self_improvement, Colors.greenAccent),
                _buildCuratedItem(context, 'Sleep Meditation', Icons.nightlight_round, Colors.indigoAccent),
                _buildCuratedItem(context, 'Anxiety Relief', Icons.spa, Colors.teal),
              ],
              screenWidth,
              screenHeight,
            ),
            SizedBox(height: screenHeight * 0.03),
            _buildSectionTitle('Breathwork', screenWidth),
            _buildCuratedGrid(
              [
                _buildCuratedItem(context, 'Deep Breathing', Icons.air, Colors.lightBlueAccent),
                _buildCuratedItem(context, '4-7-8 Breathing', Icons.slow_motion_video, Colors.cyanAccent),
                _buildCuratedItem(context, 'Box Breathing', Icons.crop_square, Colors.blueGrey),
              ],
              screenWidth,
              screenHeight,
            ),
            SizedBox(height: screenHeight * 0.03),
            _buildSectionTitle('Stories', screenWidth),
            _buildCuratedGrid(
              [
                _buildCuratedItem(context, 'Inspiring Tales', Icons.book, Colors.redAccent),
                _buildCuratedItem(context, 'Bedtime Stories', Icons.bedtime, Colors.deepPurpleAccent),
                _buildCuratedItem(context, 'Life Lessons', Icons.menu_book, Colors.pinkAccent),
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
      physics: const NeverScrollableScrollPhysics(), // Prevent scrolling within the grid
      shrinkWrap: true, // Allows the GridView to take only the necessary height
      crossAxisCount: 3, // Number of columns in the grid
      crossAxisSpacing: screenWidth * 0.04,
      mainAxisSpacing: screenHeight * 0.02,
      childAspectRatio: 1.5,
      children: items,
    );
  }

  Widget _buildCuratedItem(BuildContext context, String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        // Define action when the item is tapped
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You selected: $title')),
        );
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
