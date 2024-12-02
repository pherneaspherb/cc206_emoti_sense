import 'package:flutter/material.dart';
import 'moods_page.dart';
import 'discover_page.dart';
import 'games_page.dart';
import 'profile_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  // Moods functionality
  final List<String> _moods = [];
  final Set<String> _favorites = {};
  final TextEditingController _moodController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addMood(String mood) {
    setState(() {
      _moods.add(mood);
      _moodController.clear();
    });
  }

  void _toggleFavorite(String mood) {
    setState(() {
      if (_favorites.contains(mood)) {
        _favorites.remove(mood);
      } else {
        _favorites.add(mood);
      }
    });
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
            const Icon(Icons.format_quote, color: Colors.blue, size: 24), // Left quote icon
            const SizedBox(width: 8),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 24, // Increased font size
                    fontStyle: FontStyle.italic,
                    color: Colors.black87,
                    fontFamily: 'Apple Garamond', // Set the font to Sarcolenta
                  ),
                  children: [
                    const TextSpan(
                      text: "Happiness is not something ready-made. It comes from your own actions. ",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    const TextSpan(
                      text: "- Dalai Lama",
                      style: TextStyle(fontWeight: FontWeight.bold), // Making the author's name bold
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.format_quote, color: Colors.blue, size: 24), // Right quote icon
          ],
        ),
        const SizedBox(height: 16),

        // Wellness Tip of the Day Section
        const Text(
          "Wellness Tip of the Day",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF1B3C73), // Set the background color to 1B3C73
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: const Text(
                  "Take a 5-minute break every hour to stretch and breathe deeply.",
                  style: TextStyle(fontSize: 16, color: Colors.white), // Text color set to white
                ),
              ),
              const SizedBox(width: 8),
              Image.asset(
                'assets/wellness.png', // Your wellness image
                height: 50, // Adjust the height as needed
                width: 50, // Adjust the width as needed
              ),
            ],
          ),
        ),
      ],
    );
  }

Widget _buildRecentlyPlayed() {
  final recentItems = [
    {"title": "Relaxing Meditation", "type": "Meditation"},
    {"title": "Lo-fi Beats", "type": "Music"},
    {"title": "Deep Breathing Exercise", "type": "Breathwork"},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Recently Played",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      Column(
        children: recentItems.map((item) {
          // Define the gradient colors based on the type
          List<Color> gradientColors;

          if (item["type"] == "Music") {
            gradientColors = [Colors.blue.shade700, Colors.blue.shade300]; // Blue gradient
          } else if (item["type"] == "Meditation") {
            gradientColors = [Colors.orange.shade700, Colors.orange.shade400]; // Orange gradient
          } else {
            gradientColors = [Colors.red.shade700, Colors.red.shade400]; // Red gradient
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
                color: Colors.white, // Icon color changed to white
              ),
              title: Text(
                item["title"]!,
                style: const TextStyle(color: Colors.white), // Title text color changed to white
              ),
              subtitle: Text(
                item["type"]!,
                style: const TextStyle(color: Colors.white), // Subtitle text color changed to white
              ),
              trailing: const Icon(
                Icons.play_arrow,
                color: Colors.white, // Play icon color changed to white
              ),
              onTap: () {
                // Handle playback navigation
                print("Playing: ${item['title']}");
              },
            ),
          );
        }).toList(),
      ),
    ],
  );
}
Widget _buildHomePage() {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(screenWidth * 0.04),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade800, // Darker blue
                  Colors.blue.shade500, // Medium blue
                  Colors.blue.shade300, // Lighter blue
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
                    Expanded(
                      child: Text(
                        'Hello, Yebe!',
                        style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          color: Colors.white, // Changed text color to white
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.mood, color: Colors.white, size: screenWidth * 0.07),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MoodsPage(
                              moods: _moods,
                              favorites: _favorites.toList(),
                              onMoodDeleted: (mood) {
                                setState(() {
                                  _moods.remove(mood);
                                  _favorites.remove(mood);
                                });
                              },
                              onClearAll: () {
                                setState(() {
                                  _moods.clear();
                                  _favorites.clear();
                                });
                              },
                              onToggleFavorite: _toggleFavorite,
                              onMoodEdited: (String value) {},
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                TextField(
                  controller: _moodController,
                  decoration: InputDecoration(
                    hintText: "How are you feeling?",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.015,
                    ),
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      _addMood(value);
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildMiddleSection(),
          const SizedBox(height: 20),
          _buildRecentlyPlayed(),
        ],
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomePage(),
      const DiscoverPage(),
      const GamesPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png', // Replace with the path to your logo
              height: 30,
            ),
            const SizedBox(width: 8),
            const Text(
              "EmotiSense", 
              style: TextStyle(fontWeight: FontWeight.bold), // Set font weight to bold for Home
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
     body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: const Color(0xFF1B3C73),
      unselectedItemColor: const Color(0xFF0D99FF), // Dark blue color
      items: List.generate(4, (index) {
        bool isSelected = index == _selectedIndex;
        return BottomNavigationBarItem(
          icon: Container(
            decoration: BoxDecoration(
              border: isSelected
                  ? Border.all(color: const Color(0xFF1B3C73), width: 2)
                  : null,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              index == 0
                  ? Icons.dashboard
                  : index == 1
                      ? Icons.search
                      : index == 2
                          ? Icons.videogame_asset
                          : Icons.account_circle,
              color: isSelected ? const Color(0xFF1B3C73) : const Color(0xFF0D99FF),
            ),
          ),
          label: index == 0
              ? 'Dashboard'
              : index == 1
                  ? 'Discover'
                  : index == 2
                      ? 'Games'
                      : 'Profile',
        );
      }),
    ),
    );
  }
}
