import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:cc206_emoti_sense/provider/recent_items.dart'; 

class BreathworkPage extends StatelessWidget {
  const BreathworkPage({super.key});

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Update recent items when a breathwork video is tapped
  void _updateRecent(BuildContext context, String title, String type) {
    final recent = Provider.of<RecentItems>(context, listen: false); 
    recent.addRecentItem(title, type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathwork', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.green.shade400,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade400, Colors.green.shade200],
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
                  Text(
                    'Breathwork Sessions',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 16.0),
                  _buildPlaylistItem(
                    title: '60 Seconds Breathing Exercise',
                    videoUrl: 'https://www.youtube.com/watch?v=Dx112W4i5I0',
                    icon: Icons.access_alarm,
                    onTap: () => _updateRecent(context, '60 Seconds Breathing Exercise', 'Breathwork'),
                  ),
                  _buildPlaylistItem(
                    title: 'Breathing Exercise for Stress and Anxiety',
                    videoUrl: 'https://www.youtube.com/watch?v=eZBa63NZbbE',
                    icon: Icons.nightlight_round,
                    onTap: () => _updateRecent(context, 'Breathing Exercise for Stress and Anxiety', 'Breathwork'),
                  ),
                  _buildPlaylistItem(
                    title: '4-7-8 Breathing Technique',
                    videoUrl: 'https://www.youtube.com/watch?v=kpSkoXRrZnE',
                    icon: Icons.favorite_border,
                    onTap: () => _updateRecent(context, '4-7-8 Breathing Technique', 'Breathwork'),
                  ),
                  _buildPlaylistItem(
                    title: '30 Seconds Breathing Exercise',
                    videoUrl: 'https://www.youtube.com/watch?v=Fu6XOe6SwHI',
                    icon: Icons.self_improvement,
                    onTap: () => _updateRecent(context, '30 Seconds Breathing Exercise', 'Breathwork'),
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
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.green.shade400, size: 40), 
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green.shade600), 
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _launchURL(videoUrl);
              },
              child: Text('Watch', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade400), 
            ),
          ],
        ),
      ),
    );
  }
}
