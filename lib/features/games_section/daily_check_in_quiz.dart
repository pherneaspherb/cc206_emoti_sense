import 'package:flutter/material.dart';

class DailyCheckInQuizPage extends StatefulWidget {
  const DailyCheckInQuizPage({super.key});

  @override
  _DailyCheckInQuizPageState createState() => _DailyCheckInQuizPageState();
}

class _DailyCheckInQuizPageState extends State<DailyCheckInQuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  final List<Map<String, Object>> _questions = [
    {
      'question': 'How was your overall mood today?',
      'options': [
        {'text': 'Happy', 'score': 10},
        {'text': 'Neutral', 'score': 5},
        {'text': 'Stressed', 'score': 2},
        {'text': 'Sad', 'score': 1},
      ],
    },
    {
      'question': 'How productive did you feel today?',
      'options': [
        {'text': 'Very Productive', 'score': 10},
        {'text': 'Somewhat Productive', 'score': 5},
        {'text': 'Not Really', 'score': 2},
        {'text': 'Not at All', 'score': 1},
      ],
    },
    {
      'question': 'How well did you sleep last night?',
      'options': [
        {'text': 'Very Well', 'score': 10},
        {'text': 'Okay', 'score': 5},
        {'text': 'Not Much', 'score': 2},
        {'text': 'Terrible', 'score': 1},
      ],
    },
  ];

  void _answerQuestion(int score) {
    setState(() {
      _score += score;
      _currentQuestionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daily Check-In Quiz',
          style: TextStyle(
            color: Colors.white, // White text for the AppBar
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 211, 47, 47), // Dark red
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 211, 47, 47), // Dark red
              Color.fromARGB(255, 244, 67, 54), // Lighter red
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: _currentQuestionIndex < _questions.length
            ? _buildQuizContent()
            : _buildResultContent(),
      ),
    );
  }

  Widget _buildQuizContent() {
    final question = _questions[_currentQuestionIndex];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            question['question'] as String,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white, // White text for the question
            ),
          ),
          const SizedBox(height: 16.0),
          ...(question['options'] as List<Map<String, Object>>).map((option) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0), // Adds space below each option
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 211, 47, 47), backgroundColor: Colors.white, // Dark red text color
                  padding: const EdgeInsets.all(16.0),
                  side: const BorderSide(color: Color.fromARGB(255, 211, 47, 47), width: 2), // Dark red border
                ),
                child: Text(option['text'] as String),
                onPressed: () => _answerQuestion(option['score'] as int),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildResultContent() {
    String feedback;
    if (_score > 25) {
      feedback = 'You seem to be in a great mood today! Keep it up!';
    } else if (_score > 15) {
      feedback = 'You had an okay day. Consider some relaxation time.';
    } else {
      feedback = 'You might be feeling down. Try some deep breathing or calming music.';
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Your Score: $_score',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white, // White text for the score
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          Text(
            feedback,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white, // White text for feedback
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _resetQuiz,
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 211, 47, 47), backgroundColor: Colors.white, // Dark red text color
              padding: const EdgeInsets.all(16.0),
              side: const BorderSide(color: Color.fromARGB(255, 211, 47, 47), width: 2), // Dark red border
            ),
            child: const Text('Retake Quiz'),
          ),
        ],
      ),
    );
  }
}
