import 'dart:math';

class QuotesDataset {
  static const List<Map<String, String>> quotes = [
    {
      "quote": 'In the end, we will remember not the words of our enemies, but the silence of our friends.',
      "author": 'Martin Luther King Jr.'
    },
    {
      "quote": 'The future belongs to those who believe in the beauty of their dreams.',
      "author": 'Eleanor Roosevelt'
    },
    {
      "quote": 'It does not matter how slowly you go as long as you do not stop.',
      "author": 'Confucius'
    },
    {
      "quote": 'You are enough just as you are.',
      "author": 'Meghan Markle'
    },
    {
      "quote": 'Happiness is not something ready made. It comes from your own actions.',
      "author": 'Dalai Lama'
    },
    {
      "quote": 'Take one day at a time.',
      "author": 'Unknown'
    },
    {
      "quote": 'Healing is not linear.',
      "author": 'Unknown'
    },
    {
      "quote": 'When you feel like giving up, remember why you started.',
      "author": 'Unknown'
    },
    {
      "quote": 'Your mental health is a priority. Your happiness is essential. Your self-care is a necessity.',
      "author": 'Unknown'
    },
    {
      "quote": 'Progress, not perfection.',
      "author": 'Unknown'
    },
    {
      "quote": 'You don\'t have to be perfect to be amazing.',
      "author": 'Unknown'
    },
    {
      "quote": 'Sometimes the most important thing in a whole day is the rest we take between two deep breaths.',
      "author": 'Etty Hillesum'
    },
    {
      "quote": 'Self-care is how you take your power back.',
      "author": 'Lalah Delia'
    },
    {
      "quote": 'Mental health is not a destination, but a process. It\'s about how you drive, not where you\'re going.',
      "author": 'Noam Spencer'
    },
    {
      "quote": 'The greatest wealth is to live content with little.',
      "author": 'Plato'
    },
    {
      "quote": 'You are not your thoughts. You are the observer of your thoughts.',
      "author": 'Unknown'
    },
    {
      "quote": 'The best way out is always through.',
      "author": 'Robert Frost'
    },
    {
      "quote": 'Self-love is not selfish; you cannot truly love another until you know how to love yourself.',
      "author": 'RuPaul'
    },
    {
      "quote": 'You are allowed to be both a masterpiece and a work in progress simultaneously.',
      "author": 'Sophia Bush'
    },
  ];

  // Fetch a random quote from the dataset
  static Map<String, String> getRandomQuote() {
    final randomIndex = Random().nextInt(quotes.length);
    return quotes[randomIndex];
  }
}
