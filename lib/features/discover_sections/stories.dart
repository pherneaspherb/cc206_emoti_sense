import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PoemsPage extends StatefulWidget {
  const PoemsPage({super.key});

  @override
  _PoemsPageState createState() => _PoemsPageState();
}

class _PoemsPageState extends State<PoemsPage> {
  bool isLoading = true;
  List poems = [];
  final apiKey = '12345'; // Replace with your actual API key

  @override
  void initState() {
    super.initState();
    // Example category to fetch poems (replace with user input)
    fetchPoems('love');
  }

  Future fetchPoems(String category) async {
    setState(() {
      isLoading = true;
    });

    var url = Uri.parse(
        'https://api.poems.one/poem/search'); // Correct endpoint
    var response = await http.get(url, headers: {
      'X-PoemsOne-Api-Secret': apiKey
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data); // Debugging: check the raw response

      // Assuming 'poems' contains the list of poem data in the response body
      if (data['poems'] != null && data['poems'].isNotEmpty) {
        setState(() {
          poems = data['poems'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          poems = []; // No poems found
        });
        print("No poems found.");
      }
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception("Failed to load poems");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Poems')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : poems.isEmpty
              ? const Center(child: Text('No poems available'))
              : ListView.builder(
                  itemCount: poems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(poems[index]['title'] ?? 'No title'),
                      subtitle: Text(poems[index]['content'] ?? 'No content'),
                    );
                  },
                ),
    );
  }
}
