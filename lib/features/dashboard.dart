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
      _buildCustomAppBar("Dashboard"), 
      _buildCustomAppBar("Discover"),  
      _buildCustomAppBar("Games"),
      _buildCustomAppBar("Profile"),   
    ];

    return Scaffold(
      appBar: appBars[_navigation.selectedIndex], 
      body: Container(
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
        child: SafeArea(
          child: pages[_navigation.selectedIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _navigation.selectedIndex,
        onTap: (index) => setState(() => _navigation.onItemTapped(index)),
        selectedItemColor: const Color(0xFF1B3C73),
        unselectedItemColor: const Color(0xFF0D99FF),
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

  // Custom AppBar with deep blue background
  PreferredSizeWidget _buildCustomAppBar(String title) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            'assets/logo.png',
            height: 30,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF003366), // Deep blue background
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }
}
