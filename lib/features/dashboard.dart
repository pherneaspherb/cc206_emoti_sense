import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            'Welcome to the Stress Relief App',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to Music feature
            },
            child: const Text('Music'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to Breathing Exercise feature
            },
            child: const Text('Breathing Exercise'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to Meditation feature
            },
            child: const Text('Meditation'),
          ),
        ],
      ),
    );
  }
}
