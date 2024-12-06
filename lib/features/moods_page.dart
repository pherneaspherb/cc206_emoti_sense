import 'package:flutter/material.dart';

class MoodsPage extends StatefulWidget {
  final List<String> moods;
  final ValueChanged<String> onMoodDeleted;

  MoodsPage({
    required this.moods,
    required this.onMoodDeleted, required Null Function() onClearAll,
  });

  @override
  _MoodsPageState createState() => _MoodsPageState();
}

class _MoodsPageState extends State<MoodsPage> {
  late List<String> moods;

  @override
  void initState() {
    super.initState();
    moods = widget.moods; 
  }

  // Method to clear all moods
  void clearAllMoods() {
    setState(() {
      moods.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('All moods cleared.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Moods', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color(0xFF003366),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white), 
            onPressed: clearAllMoods, 
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF003366),
              Color(0xFF1a3d66), 
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: moods.length,
                itemBuilder: (context, index) {
                  final mood = moods[index];

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      title: Text(mood, style: TextStyle(color: Colors.black)), 
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          widget.onMoodDeleted(mood); // Calls onMoodDeleted from parent
                          setState(() {
                            moods.remove(mood); 
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Mood "$mood" deleted.'),
                            ),
                          );
                        },
                      ),
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
