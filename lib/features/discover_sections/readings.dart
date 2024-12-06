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

  final List<Color> gradientColors = [Colors.pink.shade700, Colors.pink.shade400];

  Future<void> fetchCollections(String searchTerm) async {
    setState(() {
      isLoading = true;
    });

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
    final recent = Provider.of<RecentItems>(context, listen: false); 
    recent.addRecentItem(title, type);
  }

  @override
  void initState() {
    super.initState();
    fetchCollections('hope');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Collection of Poems for You',
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.pink.shade700, 
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
                fillColor: Colors.white, 
                labelText: 'Search for poems',
                labelStyle: TextStyle(color: Colors.pink.shade700),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30), 
                ),
                prefixIcon: Icon(Icons.search, color: Colors.pink.shade700),
              ),
              onSubmitted: (value) {
                fetchCollections(value); 
              },
            ),
            SizedBox(height: 10),
            isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.pink.shade700)) 
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
                                    color: Colors.pink.shade700, 
                                  ),
                                ),
                                subtitle: Text(
                                  'by ${collection['author']}',
                                  style: TextStyle(color: Colors.pink.shade400), 
                                ),
                                trailing: Icon(Icons.remove_red_eye, color: Colors.pink.shade700), 
                                onTap: () {
                                  _updateRecent(context, collection['title'], 'Reading'); 
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
                            style: TextStyle(fontSize: 16, color: Colors.pink.shade400), 
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
            fontWeight: FontWeight.bold, 
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.pink.shade700, 
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity, 
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade700, Colors.pink.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center( 
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              width: 400, 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white, 
                      borderRadius: BorderRadius.circular(10), 
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
                            fontWeight: FontWeight.bold, 
                            color: Colors.pink.shade700,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'by ${collection['author']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic, 
                            color: Colors.pink.shade400,
                          ),
                        ),
                        SizedBox(height: 20),
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
