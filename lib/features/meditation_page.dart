// meditation_page.dart
import 'package:flutter/material.dart';
import 'discover_page.dart'; // Import Discover Page here

class MeditationPage extends StatelessWidget {
  const MeditationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        // Navigate to Discover Page when back button is pressed
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DiscoverPage()),
        );
        return false; // Prevents going back to the previous page
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Meditation'),
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
              _buildSectionTitle('Meditation Techniques', screenWidth),
              _buildCuratedGrid(
                context, // Pass context here
                [
                  _buildCuratedItem(
                    context, // Pass context here
                    'Mindfulness',
                    Icons.self_improvement,
                    Colors.greenAccent,
                    'Focus on the present moment and acknowledge thoughts and feelings without judgment.',
                  ),
                  _buildCuratedItem(
                    context, // Pass context here
                    'Sleep Meditation',
                    Icons.nightlight_round,
                    Colors.indigoAccent,
                    'Embrace the night with soothing sounds and relaxation.',
                  ),
                  _buildCuratedItem(
                    context, // Pass context here
                    'Anxiety Relief',
                    Icons.spa,
                    Colors.teal,
                    'Calm your mind and reclaim your inner strength.',
                  ),
                ],
                screenWidth,
                screenHeight,
              ),
            ],
          ),
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

  Widget _buildCuratedGrid(BuildContext context, List<Widget> items, double screenWidth, double screenHeight) {
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

  Widget _buildCuratedItem(BuildContext context, String title, IconData icon, Color color, String description) {
    return GestureDetector(
      onTap: () {
        // Display the description in a Snackbar for simplicity
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(description)),
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
