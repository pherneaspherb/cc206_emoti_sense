import 'package:flutter/material.dart';
import 'moods_page.dart'; // Import the MoodsPage file

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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.04;
    final verticalPadding = screenHeight * 0.02;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
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
                                  favorites: _favorites.toList(), // Pass favorites to MoodsPage
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
                                  onToggleFavorite: _toggleFavorite, onMoodEdited: (String value) {}, // Pass toggle function
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
      ),
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
            icon: Icon(Icons.chat),
            label: 'AI Chat',
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

  Widget _buildGridItem(String title, IconData icon, Color color) {
    return Container(
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: color),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}