import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:cc206_emoti_sense/provider/recent_items.dart';

class ReadingsPage extends StatefulWidget {
  @override
  _ReadingsPageState createState() => _ReadingsPageState();
}

class _ReadingsPageState extends State<ReadingsPage> {
  bool isLoading = false;
  List<Map<String, dynamic>> collections = [];

  // Gradient colors for the background
  final List<Color> gradientColors = [Colors.pink.shade700, Colors.pink.shade400];

  Future<void> fetchCollections(String searchTerm) async {
    setState(() {
      isLoading = true;
    });

    // API URL with search term
    final url = Uri.parse('https://poetrydb.org/lines/$searchTerm');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          collections = List<Map<String, dynamic>>.from(data.map((item) => {
                'title': item['title'] ?? 'Unknown Title',
                'author': item['author'] ?? 'Unknown Author',
                'lines': item['lines'] ?? [],
              }));
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load poetry collections');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  // Update recent items when a poem collection is tapped
  void _updateRecent(BuildContext context, String title, String type) {
    final recent = Provider.of<RecentItems>(context, listen: false); // Get the context to access RecentItems provider
    recent.addRecentItem(title, type);
  }

  @override
  void initState() {
    super.initState();
    fetchCollections('hope'); // Default search term
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Collection of Poems for You',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Bold text
            color: Colors.white, // White text color
          ),
        ),
        backgroundColor: Colors.pink.shade700, // Use pink shade 700 for the AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white, // Set the background color to white
                labelText: 'Search for poems',
                labelStyle: TextStyle(color: Colors.pink.shade700), // Label color to match pink shade
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded corners with radius 30
                ),
                prefixIcon: Icon(Icons.search, color: Colors.pink.shade700), // Icon color to match pink shade
              ),
              onSubmitted: (value) {
                fetchCollections(value); // Fetch data on submit
              },
            ),
            SizedBox(height: 10),
            isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.pink.shade700)) // Progress indicator color
                : collections.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: collections.length,
                          itemBuilder: (context, index) {
                            final collection = collections[index];
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              elevation: 4,
                              child: ListTile(
                                contentPadding: EdgeInsets.all(10),
                                title: Text(
                                  collection['title'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink.shade700, // Title text color
                                  ),
                                ),
                                subtitle: Text(
                                  'by ${collection['author']}',
                                  style: TextStyle(color: Colors.pink.shade400), // Author text color
                                ),
                                trailing: Icon(Icons.remove_red_eye, color: Colors.pink.shade700), // Eye icon instead of arrow
                                onTap: () {
                                  _updateRecent(context, collection['title'], 'Reading'); // Update recent on tap
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CollectionDetails(),
                                      settings: RouteSettings(arguments: collection),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      )
                    : Expanded(
                        child: Center(
                          child: Text(
                            'No poems found. Try searching for another term.',
                            style: TextStyle(fontSize: 16, color: Colors.pink.shade400), // No poems text color
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
class CollectionDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final collection =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          collection['title'],
          style: TextStyle(
            fontWeight: FontWeight.bold, // Bold text for title
            color: Colors.white, // White text color for the AppBar title
          ),
        ),
        backgroundColor: Colors.pink.shade700, // AppBar color
      ),
      body: Container(
        width: double.infinity, // Extend to full width
        height: double.infinity, // Extend to full height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade700, Colors.pink.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center( // Center the poem container
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              width: 400, // Set a specific width for the content box
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white, // White container for the poem content
                      borderRadius: BorderRadius.circular(10), // Rounded corners with 10 pixels
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          collection['title'],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold, // Bold title
                            color: Colors.pink.shade700, // Title color
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'by ${collection['author']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic, // Italicized author name
                            color: Colors.pink.shade400, // Author color
                          ),
                        ),
                        SizedBox(height: 20),
                        // Display the lines of the poem
                        Column(
                          children: collection['lines']
                              .map<Widget>((line) => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                                    child: Text(
                                      line,
                                      style: TextStyle(fontSize: 16),
                                      textAlign: TextAlign.left,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
