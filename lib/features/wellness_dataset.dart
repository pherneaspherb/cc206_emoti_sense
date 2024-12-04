import 'dart:math';

class WellnessDataset {
  static const List<Map<String, String>> tips = [
    {
      "tip": "Start your day with a glass of water to hydrate your body.",
    },
    {
      "tip": "Take breaks throughout the day to stretch and move your body.",
    },
    {
      "tip": "Practice mindfulness or meditation to reduce stress and improve focus.",
    },
    {
      "tip": "Make time for hobbies and activities that make you happy.",
    },
    {
      "tip": "Ensure you're getting enough sleep each night, ideally 7-9 hours.",
    },
    {
      "tip": "Eat a balanced diet with plenty of fruits, vegetables, and whole grains.",
    },
    {
      "tip": "Take deep breaths when feeling overwhelmed to help calm your mind.",
    },
    {
      "tip": "Stay connected with friends and family for emotional support.",
    },
    {
      "tip": "Engage in physical activity that you enjoy, such as walking or yoga.",
    },
    {
      "tip": "Practice gratitude daily to boost your mood and perspective.",
    },
    {
      "tip": "Set aside time each day for self-care, even if it's just a few minutes.",
    },
    {
      "tip": "Limit screen time before bed to improve sleep quality.",
    },
    {
      "tip": "Laugh often to reduce stress and improve overall well-being.",
    },
    {
      "tip": "Take time to relax and recharge when needed to avoid burnout.",
    },
    {
      "tip": "Journaling can help clear your mind and reduce stress.",
    },
    {
      "tip": "Avoid multitasking to improve productivity and reduce anxiety.",
    },
    {
      "tip": "Focus on what you can control and let go of what you can't.",
    },
    {
      "tip": "Stay present in the moment and appreciate the little things.",
    },
  ];

  // Fetch a random wellness tip from the dataset
  static Map<String, String> getRandomWellnessTip() {
    final randomIndex = Random().nextInt(tips.length);
    return tips[randomIndex];
  }
}
