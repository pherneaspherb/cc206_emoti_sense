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

PreferredSizeWidget buildAppBar() {
  return AppBar(
    title: Row(
      children: [
        Image.asset(
          'assets/logo.png',
          height: 30,
        ),
        const SizedBox(width: 8),
        const Text(
          "Games",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    automaticallyImplyLeading: false,
  );
}

class _GamesPageState extends State<GamesPage> {
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
        child: Padding(
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
                  _buildGameCard(
                    'Bubble Pop',
                    Icons.bubble_chart,
                    const Color.fromARGB(255, 148, 87, 231), // Darker purple
                    const Color.fromARGB(255, 201, 153, 255), // Lighter purple
                    context,
                    const BubblePopPage(),
                  ),
                  _buildGameCard(
                    'Mood Matching Game',
                    Icons.tag_faces,
                    const Color.fromARGB(255, 3, 169, 244), // Darker blue
                    const Color.fromARGB(255, 100, 181, 246), // Lighter blue
                    context,
                    const MoodMatchingGamePage(),
                  ),
                  _buildGameCard(
                    'Mindfulness Maze',
                    Icons.map,
                    const Color.fromARGB(255, 76, 175, 80), // Darker green
                    const Color.fromARGB(255, 139, 195, 74), // Lighter green
                    context,
                    const MindfulnessMazePage(),
                  ),
                  _buildGameCard(
                    'Daily Check-In Quiz',
                    Icons.quiz,
                    const Color.fromARGB(255, 211, 47, 47), // Dark red
                    const Color.fromARGB(255, 244, 67, 54), // Lighter red
                    context,
                    const DailyCheckInQuizPage(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameCard(String title, IconData icon, Color color1, Color color2, BuildContext context, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
