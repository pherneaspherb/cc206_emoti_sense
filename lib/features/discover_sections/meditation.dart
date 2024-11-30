import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MeditationPage extends StatelessWidget {
  // List of YouTube video URLs for breathing exercises
  final List<Map<String, String>> videoDetails = [
    {
      'url': 'https://www.youtube.com/watch?v=Dx112W4i5I0&pp=ygUZc2hvcnQgYnJlYXRoaW5nIGV4ZXJjaXNlcw%3D%3D',
      'title': 'Breathing Exercise 1',
    },
    {
      'url': 'https://www.youtube.com/watch?v=eZBa63NZbbE&pp=ygUZc2hvcnQgYnJlYXRoaW5nIGV4ZXJjaXNlcw%3D%3D',
      'title': 'Breathing Exercise 2',
    },
    {
      'url': 'https://www.youtube.com/watch?v=kpSkoXRrZnE&pp=ygUZc2hvcnQgYnJlYXRoaW5nIGV4ZXJjaXNlcw%3D%3D',
      'title': 'Breathing Exercise 3',
    },
    {
      'url': 'https://www.youtube.com/watch?v=Fu6XOe6SwHI&pp=ygUZc2hvcnQgYnJlYXRoaW5nIGV4ZXJjaXNlcw%3D%3D',
      'title': 'Breathing Exercise 4',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Breathing Exercises"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two videos per row
          crossAxisSpacing: 8.0, // Spacing between columns
          mainAxisSpacing: 8.0, // Spacing between rows
          childAspectRatio: 1.5, // Adjust aspect ratio for tile size
        ),
        itemCount: videoDetails.length,
        itemBuilder: (context, index) {
          final video = videoDetails[index];
          final videoUrl = video['url']!;
          final videoTitle = video['title']!;

          return Card(
            margin: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () => _launchURL(videoUrl),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_circle_fill, size: 50, color: Colors.blue), // Play icon
                  SizedBox(height: 8),
                  Text(
                    videoTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Launches the YouTube URL in the browser
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url); // Parse the URL
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri); // Use launchUrl() method for newer versions
    } else {
      throw 'Could not launch $url';
    }
  }
}
