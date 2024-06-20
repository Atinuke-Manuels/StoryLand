import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class StoryProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _story;

  bool get isLoading => _isLoading;
  String? get story => _story;

  Future<void> fetchStory(int selectedAge, String name, String keyword, String category) async {
    _isLoading = true;
    notifyListeners();

    final apiKey = dotenv.env['API_KEY'] ?? '';

    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);

    int ageGroup = selectedAge;
    String instruction = selectedAge < 7
        ? 'less than 250 words with age appropriate language and themes.'
        : 'about 300 words with age appropriate language and themes.';

    final content = [
      Content.text(
          'Write a story from the $category category for $name about a $keyword using children-friendly and simple English that is suitable for $ageGroup. The story should be $instruction Remember to conclude by mentioning $name and one lesson to be learnt from the story this should be in line with the $category the story was drawn from. Lastly there should be a section called Questions where you ask $name two brief questions from the story. Remember to give the story a suitable title')
    ];

    try {
      final response = await model.generateContent(content);
      _story = response.text;
    } catch (error) {
      _story = 'Failed to generate story: $error';
    }

    _isLoading = false;
    notifyListeners();
  }
}
