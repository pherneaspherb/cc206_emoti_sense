import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MeditationPage extends StatelessWidget {
  const MeditationPage({super.key});

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
        title: const Text('Meditation'),
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
                  'Meditation Sessions',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                _buildPlaylistItem(
                  title: 'Mindfulness Meditation',
                  videoUrl: 'https://www.youtube.com/watch?v=sG7DBA-mgFY',
                  icon: Icons.access_alarm,
                ),
                _buildPlaylistItem(
                  title: 'Sleep Meditation',
                  videoUrl: 'https://www.youtube.com/watch?v=inpok4MKVLM',
                  icon: Icons.nightlight_round,
                ),
                _buildPlaylistItem(
                  title: 'Anxiety Relief Meditation',
                  videoUrl: 'https://www.youtube.com/watch?v=itZMM5gCboo',
                  icon: Icons.favorite_border,
                ),
                _buildPlaylistItem(
                  title: 'Stress Relief Meditation',
                  videoUrl: 'https://www.youtube.com/watch?v=z6X5oEIg6Ak',
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