import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MeditationPage extends StatelessWidget {
  // List of YouTube video URLs for breathing exercises
  final List<Map<String, String>> videoDetails = [
    {
      'url': 'https://www.youtube.com/watch?v=Dx112W4i5I0',
      'title': 'Breathing Exercise 1',
    },
    {
      'url': 'https://www.youtube.com/watch?v=eZBa63NZbbE',
      'title': 'Breathing Exercise 2',
    },
    {
      'url': 'https://www.youtube.com/watch?v=kpSkoXRrZnE',
      'title': 'Breathing Exercise 3',
    },
    {
      'url': 'https://www.youtube.com/watch?v=Fu6XOe6SwHI',
      'title': 'Breathing Exercise 4',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Breathing Exercises"),
      ),
      body: ListView.builder(
        itemCount: videoDetails.length,
        itemBuilder: (context, index) {
          final video = videoDetails[index];
          final videoUrl = video['url']!;
          final videoTitle = video['title']!;

          // Set a random color for the card
          Color cardColor = _getCardColor(index);

          // Icon for each exercise (you can modify these as per your preference)
          IconData icon = Icons.access_alarm;

          // Set different icons for each exercise
          if (index == 0) {
            icon = Icons.spa;
          } else if (index == 1) {
            icon = Icons.airline_seat_individual_suite;
          } else if (index == 2) {
            icon = Icons.favorite;
          } else if (index == 3) {
            icon = Icons.beach_access;
          }

          return Card(
            color: cardColor,
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: GestureDetector(
              onTap: () => _launchURL(videoUrl),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Icon on the left side
                    Icon(
                      icon,
                      size: 50,
                      color: Colors.white,
                    ),
                    SizedBox(width: 16),
                    // Title text next to the icon, with overflow handling
                    Expanded(
                      child: Text(
                        videoTitle,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
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
      await launchUrl(uri); // Open the URL in the browser
    } else {
      print('Could not launch $url');
    }
  }

  // Function to get a random color for each card
  Color _getCardColor(int index) {
    // Return different colors for each card
    if (index == 0) {
      return Colors.blueAccent;
    } else if (index == 1) {
      return Colors.orangeAccent;
    } else if (index == 2) {
      return Colors.greenAccent;
    } else if (index == 3) {
      return Colors.pinkAccent;
    } else {
      return Colors.tealAccent;
    }
  }
}
