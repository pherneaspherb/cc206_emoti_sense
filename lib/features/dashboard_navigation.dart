import 'dart:convert';
import 'package:flutter/material.dart';
import 'moods_page.dart';
import 'package:provider/provider.dart';
import 'package:cc206_emoti_sense/provider/recent_items.dart';
import 'quotes_dataset.dart';
import 'wellness_dataset.dart'; // Import your custom dataset

class DashboardNavigation {
  int selectedIndex = 0;
  final List<String> moods = [];
  final Set<String> favorites = {};
  final TextEditingController moodController = TextEditingController();
  String dailyQuote = "Loading quote..."; // Initialize with a placeholder quote
  String dailyTip = "Loading tip..."; 

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
      dailyQuote = '${quoteData['quote']} - ${quoteData['author']}';
    });
  }

  void fetchDailyTip(StateSetter setState) {
    final quoteTip = WellnessDataset.getRandomWellnessTip(); // Fetching from local dataset
    setState(() {
      dailyTip= '${quoteTip['tip']}';
    });
  }

  // Build the AppBar for the Dashboard
  PreferredSizeWidget buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            'assets/emo-logo-white.png',
            height: 30,
          ),
          const SizedBox(width: 8),
          const Text(
            "Home",
            style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white),
          ),
        ],
      ),
      backgroundColor: Color(0xFF003366),
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }

  // Build the Home Page with dynamic quote and mood management
  Widget buildHomePage(BuildContext context, StateSetter setState) {
    // Fetch the quote on page load
    fetchDailyQuote(setState);
    fetchDailyTip(setState);
    

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
                    Color.fromARGB(255, 25, 118, 210),
                    Color.fromARGB(255, 100, 181, 246),
                  ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
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
  // Build the middle section with daily quote and wellness tip
Widget _buildMiddleSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Daily Inspiration",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          const Icon(Icons.format_quote, color: Color.fromARGB(255, 255, 239, 11), size: 24),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Apple Garamond',
                  color: Color.fromARGB(221, 255, 255, 255),
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
          const Icon(Icons.format_quote, color: Color.fromARGB(255, 255, 239, 11), size: 24),
        ],
      ),
      const SizedBox(height: 16),
      const Text(
        "Wellness Tip of the Day",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 233, 241, 255),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Replaced incorrect 'child:' with proper widget structure
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(221, 0, 24, 122),
                  ),
                  children: [
                    TextSpan(
                      text: dailyTip, // Display the fetched wellness tip
                    ),
                  ],
                ),
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


// Build the Recently Played section with horizontal ListView
Widget _buildRecentlyPlayed(BuildContext context) {
  final recentItems = Provider.of<RecentItems>(context).recentItems;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Recents",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      const SizedBox(height: 8),
      // Horizontal scrolling ListView
      SizedBox(
        height: 220,  // Adjusted height to make the box not too wide
        child: ListView.builder(
          scrollDirection: Axis.horizontal,  // Set scroll direction to horizontal
          itemCount: recentItems.length,
          itemBuilder: (context, index) {
            final item = recentItems[index];
            List<Color> gradientColors;

            if (item["type"] == "Music") {
              gradientColors = [Colors.purple.shade300, Colors.purple.shade100];
            } else if (item["type"] == "Meditation") {
              gradientColors = [Colors.yellow.shade700, Colors.orange.shade400];
            } else if (item["type"] == "Breathwork"){
              gradientColors = [Colors.green.shade400, Colors.green.shade200];
            } else{
              gradientColors = [Colors.pink.shade700, Colors.pink.shade400];
            } 
            return Container(
              width: 160,  // Controls the width of each item (portrait style)
              margin: const EdgeInsets.only(right: 10), // Spacing between items
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_circle_outline,
                    color: Colors.white,
                    size: 40,  // Make the play button smaller
                  ),
                  const SizedBox(height: 8), // Space between the play button and text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      item["title"]!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      item["type"]!,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}
}