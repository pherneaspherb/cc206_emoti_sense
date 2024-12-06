import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart'; // Import provider
import 'package:cc206_emoti_sense/provider/recent_items.dart'; // Import the RecentItems provider

class MeditationPage extends StatelessWidget {
  const MeditationPage({super.key});

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Update recent items when a meditation video is tapped
  void _updateRecent(BuildContext context, String title, String type) {
    final recent = Provider.of<RecentItems>(context, listen: false); // Get the context to access RecentItems provider
    recent.addRecentItem(title, type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meditation', style: TextStyle (fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.yellow.shade700, // Updated color for AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow.shade700, Colors.orange.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Meditation Sessions',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 16.0),
                  _buildPlaylistItem(
                    title: 'Mindfulness Meditation',
                    videoUrl: 'https://www.youtube.com/watch?v=sG7DBA-mgFY',
                    icon: Icons.access_alarm,
                    onTap: () => _updateRecent(context, 'Mindfulness Meditation', 'Meditation'),
                  ),
                  _buildPlaylistItem(
                    title: 'Sleep Meditation',
                    videoUrl: 'https://www.youtube.com/watch?v=inpok4MKVLM',
                    icon: Icons.nightlight_round,
                    onTap: () => _updateRecent(context, 'Sleep Meditation', 'Meditation'),
                  ),
                  _buildPlaylistItem(
                    title: 'Anxiety Relief Meditation',
                    videoUrl: 'https://www.youtube.com/watch?v=itZMM5gCboo',
                    icon: Icons.favorite_border,
                    onTap: () => _updateRecent(context, 'Anxiety Relief Meditation', 'Meditation'),
                  ),
                  _buildPlaylistItem(
                    title: 'Stress Relief Meditation',
                    videoUrl: 'https://www.youtube.com/watch?v=z6X5oEIg6Ak',
                    icon: Icons.self_improvement,
                    onTap: () => _updateRecent(context, 'Stress Relief Meditation', 'Meditation'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaylistItem({
    required String title,
    required String videoUrl,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8), // White background with slight opacity
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.orange.shade400, size: 40), // Orange icon color
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange.shade700), // Text color changed
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _launchURL(videoUrl);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade400),
              child: const Text('Watch', style: TextStyle(color: Colors.white),), // Button color
            ),
          ],
        ),
      ),
    );
  }
}
