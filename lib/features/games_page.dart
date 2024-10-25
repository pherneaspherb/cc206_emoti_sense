import 'package:flutter/material.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Games'),
        backgroundColor: Colors.lightBlue,
      ),
      body: const Center(
        child: Text(
          'Games Content',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
