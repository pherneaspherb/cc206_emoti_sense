import 'package:cc206_emoti_sense/features/journal.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                backgroundImage: AssetImage('assets/logo.png'),
                backgroundColor: Colors.grey[300],
              ),
              const SizedBox(height: 16),
              const Text(
                'Yebe',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '@loveyebe',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'yebedebi@gmail.com',
                style: TextStyle(
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
                  const Text(
                    'Enter bio here.',
                    style: TextStyle(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildProfileOption(
                    Icons.edit,
                    "Edit Profile",
                    onTap: () {
                      Navigator.pushNamed(context, '/editprofile');
                    },
                  ),
                  _buildProfileOption(Icons.favorite, "Favorites"),
                  _buildProfileOption(
                    Icons.logout,
                    "Log Out",
                    onTap: () {
                      Navigator.pushNamed(context, '/');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
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
              _buildButton(Icons.music_note, "Liked Songs"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 30, color: Colors.lightBlue),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }

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
