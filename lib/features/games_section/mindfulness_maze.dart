import 'package:flutter/material.dart';

class MindfulnessMazePage extends StatelessWidget {
  const MindfulnessMazePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mindfulness Maze',
          style: TextStyle(
            color: Colors.white, // White text for the AppBar
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 76, 175, 80), // Darker green
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 76, 175, 80), // Darker green
              const Color.fromARGB(255, 139, 195, 74), // Lighter green
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
                crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
                children: [
                  Icon(
                    Icons.map,
                    size: 80,
                    color: const Color.fromARGB(255, 76, 175, 80), // Darker green icon
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Navigate the maze mindfully, finding moments of calm and focus along the way.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white, // White text for the description
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
