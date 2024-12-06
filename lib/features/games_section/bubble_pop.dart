import 'package:flutter/material.dart';

class BubblePopPage extends StatelessWidget {
  const BubblePopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bubble Pop',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Bold title
            color: Colors.white, // White text color for the AppBar title
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 148, 87, 231), // Darker purple
      ),
      body: Container(
        width: double.infinity, // Extend to full width
        height: double.infinity, // Extend to full height
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 148, 87, 231), // Darker purple
              Color.fromARGB(255, 201, 153, 255), // Lighter purple
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              width: 400, // Set a specific width for the content box
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center all content
                crossAxisAlignment: CrossAxisAlignment.center, // Center the content horizontally
                children: [
                  // Container for icon and text
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white, // White container for content
                      borderRadius: BorderRadius.circular(10), // Rounded corners with 10 pixels
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Display the bubble chart icon on top inside the box
                        Icon(
                          Icons.bubble_chart,
                          size: 80,
                          color: Color.fromARGB(255, 148, 87, 231), // Darker purple
                        ),
                        SizedBox(height: 20), // Space between icon and text
                        Text(
                          'Pop the bubbles to release stress!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold, // Bold title
                            color: Color.fromARGB(255, 148, 87, 231), // Title color (darker purple)
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Each pop represents a calming breath.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic, // Italic text for the description
                            color: Color.fromARGB(255, 201, 153, 255), // Lighter purple for description
                          ),
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
