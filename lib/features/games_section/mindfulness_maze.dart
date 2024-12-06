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
            color: Colors.white, 
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 76, 175, 80), 
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 76, 175, 80), 
              const Color.fromARGB(255, 139, 195, 74), 
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
                    Icons.map,
                    size: 80,
                    color: const Color.fromARGB(255, 76, 175, 80), 
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Navigate the maze mindfully, finding moments of calm and focus along the way.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 76, 175, 80), 
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
