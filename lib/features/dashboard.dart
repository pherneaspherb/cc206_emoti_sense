import 'package:flutter/material.dart';
import 'moods_page.dart'; // Import the MoodsPage file
import 'discover_page.dart'; // Import the DiscoverPage file
import 'games_page.dart'; // Import the GamesPage file
import 'profile_page.dart'; // Import the ProfilePage file
import 'discover_sections/music.dart'; // Import MusicPage
import 'discover_sections/meditation.dart'; // Import MeditationPage
import 'discover_sections/breathwork.dart'; // Import BreathworkPage
import 'discover_sections/stories.dart'; // Import StoriesPage

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  final List<String> _moods = []; // List to store moods
  final Set<String> _favorites = {}; // Set to store favorite moods
  final TextEditingController _moodController = TextEditingController(); // TextField controller

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addMood(String mood) {
    setState(() {
      _moods.add(mood); // Add mood to the list
      _moodController.clear(); // Clear the text field after adding
    });
  }

  void _toggleFavorite(String mood) {
    setState(() {
      if (_favorites.contains(mood)) {
        _favorites.remove(mood); // Remove from favorites
      } else {
        _favorites.add(mood); // Add to favorites
      }
    });
  }

  // Returns the appropriate page based on the selected index
  Widget _getSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomePage();
      case 1:
        return const DiscoverPage();
      case 2:
        return const GamesPage();
      case 3:
        return const ProfilePage();
      default:
        return _buildHomePage();
    }
  }

  // Gets the title based on the selected index
  String _getAppBarTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Discover';
      case 2:
        return 'Games';
      case 3:
        return 'Profile';
      default:
        return 'Home';
    }
  }

  // Builds the Home Page with mood functionality
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
                color: Colors.lightBlueAccent,
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
                            color: Colors.white,
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
                                    _favorites.remove(mood); // Remove from favorites if deleted
                                  });
                                },
                                onClearAll: () {
                                  setState(() {
                                    _moods.clear(); // Clear all moods
                                    _favorites.clear(); // Clear all favorites
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
                        _addMood(value); // Add mood on submit
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: screenWidth * 0.04,
              mainAxisSpacing: screenHeight * 0.02,
              childAspectRatio: 1.5,
              children: [
                _buildGridItem('Music', Icons.music_note, Colors.purpleAccent),
                _buildGridItem('Meditation', Icons.self_improvement, Colors.greenAccent),
                _buildGridItem('Breathwork', Icons.air, Colors.lightBlueAccent),
                _buildGridItem('Stories', Icons.book, Colors.orangeAccent),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build grid item with navigation to respective pages
  Widget _buildGridItem(String title, IconData icon, Color color) {
  return GestureDetector(
    onTap: () {
      // Handle navigation based on the card tapped
      switch (title) {
        case 'Music':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MusicScreen()),
          );
          break;
        case 'Meditation':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MeditationScreen()),
          );
          break;
        case 'Breathwork':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BreathworkScreen()),
          );
          break;
        case 'Stories':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => StoriesScreen()),
          );
          break;
      }
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle()), // Update title based on selected tab
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.lightBlue,
      ),
      body: _getSelectedPage(), // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: 'Games',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
