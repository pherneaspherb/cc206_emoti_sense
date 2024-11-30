import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MusicPage extends StatefulWidget {
  MusicPage({Key? key}) : super(key: key);

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

  @override
  void initState() {
    super.initState();
    fetchMusicData('Motivation'); // Default search term
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Music'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search for music',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (value) {
                fetchMusicData(value); // Fetch data on submit
              },
            ),
            SizedBox(height: 10),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: musicData.length < 10 ? musicData.length : 10, // Limit to 10 items
                      itemBuilder: (context, index) {
                        final musicItem = musicData[index];
                        final title = musicItem['title'] ?? 'No title';
                        final artist = musicItem['artist-credit']?[0]['name'] ?? 'Unknown artist';
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          elevation: 4,
                          child: ListTile(
                            contentPadding: EdgeInsets.all(10),
                            title: Text(
                              title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(artist),
                            leading: Icon(Icons.music_note, color: Colors.deepPurple),
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
