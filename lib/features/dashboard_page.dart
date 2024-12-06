import 'package:flutter/material.dart';
import 'dashboard_navigation.dart';
import 'discover_page.dart';
import 'games_page.dart';
import 'profile_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _navigation = DashboardNavigation(); 

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _navigation.buildHomePage(context, setState),
      const DiscoverPage(),
      const GamesPage(),
      const ProfilePage(),
    ];

    final List<PreferredSizeWidget?> appBars = [
      _navigation.buildAppBar(), 
      _buildDiscoverAppBar(),  
      _buildGamesAppBar(),
      _buildProfileAppBar(),   
    ];

    return Scaffold(
      appBar: appBars[_navigation.selectedIndex], 
      body: Container(
        width: double.infinity,
        height: double.infinity,
        
        // Set a gradient or background color for the body
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            
            colors: [
              Color(0xFF003366), // Calming deep blue
              Color(0xFF006699), // Lighter deep blue
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            
          ),
          
        ),
        
        child: pages[_navigation.selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _navigation.selectedIndex,
        onTap: (index) => setState(() => _navigation.onItemTapped(index)),
        backgroundColor:  const Color(0xFF006699),
      
        selectedItemColor: const Color.fromARGB(255, 129, 255, 251),
        unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
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
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // Discover AppBar
  PreferredSizeWidget _buildDiscoverAppBar() {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            'assets/emo-logo-white.png',
            height: 30,
          ),
          const SizedBox(width: 8),
          const Text(
            "Discover",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Set text color to white
          ),
        ],
      ),
      backgroundColor: const Color(0xFF003366),
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }

  // Games AppBar
  PreferredSizeWidget _buildGamesAppBar() {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            'assets/emo-logo-white.png',
            height: 30,
          ),
          const SizedBox(width: 8),
          const Text(
            "Games",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Set text color to white
          ),
        ],
      ),
      backgroundColor: const Color(0xFF003366),
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }

  // Profile AppBar
  PreferredSizeWidget _buildProfileAppBar() {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            'assets/emo-logo-white.png',
            height: 30,
          ),
          const SizedBox(width: 8),
          const Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Set text color to white
          ),
        ],
      ),
      backgroundColor: const Color(0xFF003366),
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }
}
