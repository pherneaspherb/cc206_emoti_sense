import 'package:flutter/material.dart';

class MoodMatchingGamePage extends StatelessWidget {
  const MoodMatchingGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mood Matching Game',
          style: TextStyle(
            color: Colors.white, // White text for the AppBar
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 3, 169, 244), // Darker blue
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 3, 169, 244), // Darker blue
              Color.fromARGB(255, 100, 181, 246), // Lighter blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10, // Adding a drop shadow
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
                crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
                children: [
                  Icon(
                    Icons.tag_faces,
                    size: 80,
                    color: Color.fromARGB(255, 3, 169, 244), // Darker blue icon
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Match the moods with their corresponding expressions to boost emotional awareness.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 2, 32, 167), // White text for the description
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
