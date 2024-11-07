import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.lightBlue,
      ),
      body: const Center(
        child: Text(
          'Profile Content',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
