import 'package:flutter/material.dart';

class MoodMatchingGamePage extends StatelessWidget {
  const MoodMatchingGamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mood Matching Game',
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 3, 169, 244), 
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 3, 169, 244), 
              const Color.fromARGB(255, 100, 181, 246), 
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
            elevation: 10, 
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center, 
                crossAxisAlignment: CrossAxisAlignment.center, 
                children: [
                  Icon(
                    Icons.tag_faces,
                    size: 80,
                    color: const Color.fromARGB(255, 3, 169, 244), 
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Match the moods with their corresponding expressions to boost emotional awareness.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 2, 32, 167), 
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
