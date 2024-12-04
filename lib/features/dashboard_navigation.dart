import 'dart:convert';
import 'package:flutter/material.dart';
import 'moods_page.dart';
import 'package:provider/provider.dart';
import 'package:cc206_emoti_sense/provider/recent_items.dart';
import 'quotes_dataset.dart'; // Import your custom dataset

class DashboardNavigation {
  int selectedIndex = 0;
  final List<String> moods = [];
  final Set<String> favorites = {};
  final TextEditingController moodController = TextEditingController();
  String dailyQuote = "Loading quote..."; // Initialize with a placeholder quote

  // Method to handle tab switching
  void onItemTapped(int index) {
    selectedIndex = index;
  }

  // Method to add a mood to the list
  void addMood(String mood) {
    moods.add(mood);
    moodController.clear();
  }

  // Method to toggle a mood as a favorite
  void toggleFavorite(String mood) {
    if (favorites.contains(mood)) {
      favorites.remove(mood);
    } else {
      favorites.add(mood);
    }
  }

  // Fetch daily quote from the local dataset
  void fetchDailyQuote(StateSetter setState) {
    final quoteData = QuotesDataset.getRandomQuote(); // Fetching from local dataset
    setState(() {
      dailyQuote = '"${quoteData['quote']}" - ${quoteData['author']}';
    });
  }

  // Build the AppBar for the Dashboard
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

  // Build the Home Page with dynamic quote and mood management
  Widget buildHomePage(BuildContext context, StateSetter setState) {
    // Fetch the quote on page load
    fetchDailyQuote(setState);

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

  // Build the middle section with daily quote and wellness tip
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
                    fontSize: 18,
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

  // Build the Recently Played section
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
