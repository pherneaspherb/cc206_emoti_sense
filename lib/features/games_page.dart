import 'package:flutter/material.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({Key? key}) : super(key: key);

  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  String _selectedGameMessage = '';

  void _onGameTap(String gameName) {
    setState(() {
      _selectedGameMessage = 'You selected: $gameName';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GridView.count(
              shrinkWrap: true, // Makes the grid view fit the available space
              physics: const NeverScrollableScrollPhysics(), // Prevent scrolling within the grid
              crossAxisCount: 2, // Two games per row
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              children: [
                _buildGameCard('Bubble Pop', Icons.bubble_chart, Colors.purpleAccent),
                _buildGameCard('Mood Matching Game', Icons.tag_faces, Colors.blueAccent),
                _buildGameCard('Mindfulness Maze', Icons.map, Colors.greenAccent),
                _buildGameCard('Daily Check-In Quiz', Icons.quiz, Colors.teal),
              ],
            ),
            const SizedBox(height: 16.0),
            // Message displayed when a game is selected
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _selectedGameMessage,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build game cards
  Widget _buildGameCard(String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () => _onGameTap(title), // Handle tap and update the message
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.2), // Add color opacity for background
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: color),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
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
