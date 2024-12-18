import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart'; // Import provider
import 'package:cc206_emoti_sense/provider/recent_items.dart';  // Import the RecentItems provider

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  bool isLoading = false;
  List<dynamic> musicData = [];

  Future<void> fetchMusicData(String searchTerm) async {
    setState(() {
      isLoading = true;
    });

    // MusicBrainz API URL for fetching recordings based on search term
    final url = Uri.parse('https://musicbrainz.org/ws/2/recording?query=$searchTerm&fmt=json');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          musicData = data['recordings'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load music data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  // Update recent items when a music track is tapped
  void _updateRecent(BuildContext context, String title, String type) {
    final recent = Provider.of<RecentItems>(context, listen: false); // Get the context to access RecentItems provider
    recent.addRecentItem(title, type);
  }

  @override
  void initState() {
    super.initState();
    fetchMusicData('Motivation'); // Default search term
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade300, Colors.purple.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            title: const Text(
              'Find Music',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade300, Colors.purple.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                filled: true, // Make the background of the search bar white
                fillColor: Colors.white, // White background for the search bar
                labelText: 'Search for music',
                labelStyle: const TextStyle(color: Colors.black), // Dark label color for visibility
                border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(30.0), 
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white, // Set the search icon color to white
                ),
                suffixIcon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white, // Set the arrow color to white
                ),
              ),
              onSubmitted: (value) {
                fetchMusicData(value); // Fetch data on submit
              },
            ),
            const SizedBox(height: 10),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: musicData.length < 10 ? musicData.length : 10, // Limit to 10 items
                      itemBuilder: (context, index) {
                        final musicItem = musicData[index];
                        final title = musicItem['title'] ?? 'No title';
                        final artist = musicItem['artist-credit']?[0]['name'] ?? 'Unknown artist';
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 4,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            title: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(artist),
                            leading: const Icon(Icons.music_note, color: Colors.deepPurple),
                            onTap: () {
                              _updateRecent(context, title, 'Music'); // Update recent on tap
                            },
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
