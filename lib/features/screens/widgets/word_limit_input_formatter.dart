import 'package:flutter/services.dart';

class WordLimitInputFormatter extends TextInputFormatter {
  final int wordLimit;
  WordLimitInputFormatter(this.wordLimit);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    List<String> words = newValue.text.trim().split(RegExp(r'\s+'));

    if (words.length > wordLimit) {
      // Only keep the first `wordLimit` words
      String truncatedText = words.take(wordLimit).join(' ');
      return TextEditingValue(
        text: truncatedText,
        selection: TextSelection.collapsed(offset: truncatedText.length),
      );
    }
    return newValue;
  }
}
