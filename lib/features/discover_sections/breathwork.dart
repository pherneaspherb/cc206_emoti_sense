import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BreathworkPage extends StatelessWidget {
  const BreathworkPage({super.key});

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathwork'),
        backgroundColor: Colors.greenAccent,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Breathwork Sessions',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                _buildPlaylistItem(
                  title: '60 Seconds Breathing Exercise',
                  videoUrl: 'https://www.youtube.com/watch?v=Dx112W4i5I0',
                  icon: Icons.access_alarm,
                ),
                _buildPlaylistItem(
                  title: 'Breathing Exercise for Stress and Anxiety',
                  videoUrl: 'https://www.youtube.com/watch?v=eZBa63NZbbE',
                  icon: Icons.nightlight_round,
                ),
                _buildPlaylistItem(
                  title: '4-7-8 Breathing Technique',
                  videoUrl: 'https://www.youtube.com/watch?v=kpSkoXRrZnE',
                  icon: Icons.favorite_border,
                ),
                _buildPlaylistItem(
                  title: '30 Seconds Breathing Exercise',
                  videoUrl: 'https://www.youtube.com/watch?v=Fu6XOe6SwHI',
                  icon: Icons.self_improvement,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistItem({required String title, required String videoUrl, required IconData icon}) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.greenAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.green, size: 40),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _launchURL(videoUrl);
              },
              child: Text('Watch on YouTube'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
            ),
          ],
        ),
      ),
    );
  }
}
