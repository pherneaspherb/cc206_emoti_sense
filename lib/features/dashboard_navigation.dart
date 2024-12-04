import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'moods_page.dart';
import 'package:provider/provider.dart';
import 'package:cc206_emoti_sense/provider/recent_items.dart'; 

class DashboardNavigation {
  int selectedIndex = 0;
  final List<String> moods = [];
  final Set<String> favorites = {};
  final TextEditingController moodController = TextEditingController();
  String dailyQuote = "Loading quote..."; // Initialize with a placeholder quote

  void onItemTapped(int index) {
    selectedIndex = index;
  }

  void addMood(String mood) {
    moods.add(mood);
    moodController.clear();
  }

  void toggleFavorite(String mood) {
    if (favorites.contains(mood)) {
      favorites.remove(mood);
    } else {
      favorites.add(mood);
    }
  }

  // Fetch daily quote from the ZenQuotes API
  Future<void> fetchDailyQuote() async {
    final url = Uri.parse('https://zenquotes.io/api/random');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final quote = data[0]['q'] ?? 'No quote available'; // Handle no quote scenario
        final author = data[0]['a'] ?? 'Unknown author';
        dailyQuote = '"$quote" - $author';
      } else {
        throw Exception('Failed to load quote');
      }
    } catch (e) {
      dailyQuote = 'Failed to fetch quote';
      print('Error: $e');
    }

    
  }

  // Define the AppBar here
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
            "Home",
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

  Widget buildHomePage(BuildContext context, StateSetter setState) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Colors.blueAccent,
                    Colors.lightBlueAccent,
                  ],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Hello, Yebe!',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.mood, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MoodsPage(
                                moods: moods,
                                favorites: favorites.toList(),
                                onMoodDeleted: (mood) {
                                  setState(() {
                                    moods.remove(mood);
                                    favorites.remove(mood);
                                  });
                                },
                                onClearAll: () {
                                  setState(() {
                                    moods.clear();
                                    favorites.clear();
                                  });
                                },
                                onToggleFavorite: toggleFavorite,
                                onMoodEdited: (String value) {},
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: moodController,
                    decoration: const InputDecoration(
                      hintText: "How are you feeling?",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        addMood(value);
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildMiddleSection(),
            const SizedBox(height: 20),
            _buildRecentlyPlayed(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMiddleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Daily Inspiration",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.format_quote, color: Colors.blue, size: 24),
            const SizedBox(width: 8),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                    color: Colors.black87,
                  ),
                  children: [
                    TextSpan(
                      text: dailyQuote, // Display the fetched quote
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.format_quote, color: Colors.blue, size: 24),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          "Wellness Tip of the Day",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1B3C73),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "Take a 5-minute break every hour to stretch and breathe deeply.",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(width: 8),
              Image.asset(
                'assets/wellness.png',
                height: 50,
                width: 50,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentlyPlayed(BuildContext context) {
    final recentItems = Provider.of<RecentItems>(context).recentItems;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recents",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Column(
          children: recentItems.map((item) {
            List<Color> gradientColors;

            if (item["type"] == "Music") {
              gradientColors = [Colors.blue.shade700, Colors.blue.shade300];
            } else if (item["type"] == "Meditation") {
              gradientColors = [Colors.orange.shade700, Colors.orange.shade400];
            } else {
              gradientColors = [Colors.red.shade700, Colors.red.shade400];
            }

            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: Icon(
                  item["type"] == "Music"
                      ? Icons.music_note
                      : item["type"] == "Meditation"
                          ? Icons.self_improvement
                          : Icons.air,
                  color: Colors.white,
                ),
                title: Text(
                  item["title"]!,
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  item["type"]!,
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: Icon(
                  Icons.play_circle_outline,
                  color: Colors.white,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
