import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cc206_emoti_sense/features/journal.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
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
            "Profile",
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

class _ProfilePageState extends State<ProfilePage> {
  // State variables for profile data
  String _name = 'Yebe';
  String _username = '@loveyebe';
  String _email = 'yebedebi@gmail.com';
  String _bio = 'Enter bio here.';
  File? _profileImage; // Holds the profile image file

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!) as ImageProvider
                    : AssetImage('assets/yebe.png'),
                backgroundColor: Colors.grey[300],
              ),
              const SizedBox(height: 16),

              // Name
              Text(
                _name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),

              // Username
              Text(
                _username,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),

              // Email Address
              Text(
                _email,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.format_quote, color: Colors.lightBlue),
                  const SizedBox(width: 8),
                  Text(
                    _bio,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.format_quote, color: Colors.lightBlue),
                ],
              ),
              const SizedBox(height: 32),

              // Buttons
              _buildButton(
                Icons.edit,
                "Edit Profile",
                onTap: () async {
                  // Navigate to ProfileEdit and await the result
                  final updatedProfile = await Navigator.pushNamed(context, '/editprofile');

                  // Check if data was returned and update the state
                  if (updatedProfile != null && updatedProfile is Map<String, dynamic>) {
                    setState(() {
                      _name = updatedProfile['name'] ?? _name;
                      _username = updatedProfile['username'] ?? _username;
                      _email = updatedProfile['email'] ?? _email;
                      _bio = updatedProfile['bio'] ?? _bio;
                      _profileImage = updatedProfile['profileImage'];
                    });
                  }
                },
              ),
              _buildButton(Icons.favorite, "Favorites"),
              _buildButton(
                Icons.book,
                "My Journal",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JournalPage()),
                  );
                },
              ),
              _buildButton(
                Icons.logout,
                "Log Out",
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method for buttons
  Widget _buildButton(IconData icon, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.lightBlue[100],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.lightBlue),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
