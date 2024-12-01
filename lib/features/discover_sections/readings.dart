import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReadingsPage extends StatefulWidget {
  @override
  _ReadingsPageState createState() => _ReadingsPageState();
}

class _ReadingsPageState extends State<ReadingsPage> {
  bool isLoading = false;
  List<Map<String, dynamic>> collections = [];

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

  @override
  void initState() {
    super.initState();
    fetchCollections('hope'); // Default search term
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collection of Poems for You'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search for poems',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (value) {
                fetchCollections(value); // Fetch data on submit
              },
            ),
            SizedBox(height: 10),
            isLoading
                ? Center(child: CircularProgressIndicator())
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
                                  ),
                                ),
                                subtitle: Text('by ${collection['author']}'),
                                trailing: Icon(Icons.arrow_forward, color: Colors.blueAccent),
                                onTap: () {
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
                            style: TextStyle(fontSize: 16),
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
        title: Text(collection['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              collection['title'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'by ${collection['author']}',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: collection['lines'].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      collection['lines'][index],
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
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
