import 'package:flutter/material.dart';

class BubblePopPage extends StatelessWidget {
  const BubblePopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bubble Pop',
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            color: Colors.white, 
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 148, 87, 231), 
      ),
      body: Container(
        width: double.infinity, 
        height: double.infinity, 
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 148, 87, 231), 
              const Color.fromARGB(255, 201, 153, 255), 
            ],
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
                mainAxisAlignment: MainAxisAlignment.center, 
                crossAxisAlignment: CrossAxisAlignment.center, 
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.bubble_chart,
                          size: 80,
                          color: const Color.fromARGB(255, 148, 87, 231), 
                        ),
                        SizedBox(height: 20), 
                        Text(
                          'Pop the bubbles to release stress!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold, 
                            color: const Color.fromARGB(255, 148, 87, 231), 
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Each pop represents a calming breath.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic, 
                            color: const Color.fromARGB(255, 201, 153, 255), 
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
