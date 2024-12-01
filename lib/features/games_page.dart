
import 'package:flutter/material.dart';
import 'package:cc206_emoti_sense/features/games_section/mood_matching_game.dart';
import 'package:cc206_emoti_sense/features/games_section/mindfulness_maze.dart';
import 'package:cc206_emoti_sense/features/games_section/daily_check_in_quiz.dart';
import 'package:cc206_emoti_sense/features/games_section/bubble_pop.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({Key? key}) : super(key: key);

  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              children: [
                _buildGameCard('Bubble Pop', Icons.bubble_chart, Colors.purpleAccent, context, const BubblePopPage()),
                _buildGameCard('Mood Matching Game', Icons.tag_faces, Colors.blueAccent, context, const MoodMatchingGamePage()),
                _buildGameCard('Mindfulness Maze', Icons.map, Colors.greenAccent, context, const MindfulnessMazePage()),
                _buildGameCard('Daily Check-In Quiz', Icons.quiz, Colors.teal, context, const DailyCheckInQuizPage()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build game cards with navigation
  Widget _buildGameCard(String title, IconData icon, Color color, BuildContext context, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
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
