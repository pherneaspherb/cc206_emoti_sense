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
                _buildCuratedItem(
                    'Chill Beats', Icons.music_note, Colors.purpleAccent),
                _buildCuratedItem(
                    'Focus Tunes', Icons.headphones, Colors.blueAccent),
                _buildCuratedItem(
                    'Feel Good', Icons.audiotrack, Colors.orangeAccent),
              ],
              screenWidth,
              screenHeight,
            ),
            SizedBox(height: screenHeight * 0.03),
            _buildSectionTitle('Meditation', screenWidth),
            _buildCuratedGrid(
              [
                _buildCuratedItem(
                    'Mindfulness', Icons.self_improvement, Colors.greenAccent),
                _buildCuratedItem('Sleep Meditation', Icons.nightlight_round,
                    Colors.indigoAccent),
                _buildCuratedItem(
                    'Anxiety Relief', Icons.spa, Colors.teal),
              ],
              screenWidth,
              screenHeight,
            ),
            SizedBox(height: screenHeight * 0.03),
            _buildSectionTitle('Breathwork', screenWidth),
            _buildCuratedGrid(
              [
                _buildCuratedItem(
                    'Deep Breathing', Icons.air, Colors.lightBlueAccent),
                _buildCuratedItem(
                    '4-7-8 Breathing', Icons.slow_motion_video, Colors.cyanAccent),
                _buildCuratedItem(
                    'Box Breathing', Icons.crop_square, Colors.blueGrey),
              ],
              screenWidth,
              screenHeight,
            ),
            SizedBox(height: screenHeight * 0.03),
            _buildSectionTitle('Stories', screenWidth),
            _buildCuratedGrid(
              [
                _buildCuratedItem(
                    'Inspiring Tales', Icons.book, Colors.redAccent),
                _buildCuratedItem(
                    'Bedtime Stories', Icons.bedtime, Colors.deepPurpleAccent),
                _buildCuratedItem(
                    'Life Lessons', Icons.menu_book, Colors.pinkAccent),
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

  Widget _buildCuratedItem(String title, IconData icon, Color color) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          print('Swiped right on $title');
        } else if (details.primaryVelocity! < 0) {
          print('Swiped left on $title');
        }
      },
      onScaleUpdate: (details) {
        if (details.scale > 1.0) {
          print('Pinching out on $title');
        } else if (details.scale < 1.0) {
          print('Pinching in on $title');
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
