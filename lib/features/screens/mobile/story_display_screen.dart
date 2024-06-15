import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share_plus/share_plus.dart';


class StoryDisplayScreen extends StatefulWidget {
  final String story;

  const StoryDisplayScreen({super.key, required this.story});

  @override
  _StoryDisplayScreenState createState() => _StoryDisplayScreenState();
}

class _StoryDisplayScreenState extends State<StoryDisplayScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  String _language = 'en-US';
  bool _isSpeaking = false; // New variable to track the speaking state

  // Ensure the TTS method is disposed of when the widget is no longer in focus.
  @override
  void dispose() {
    _flutterTts.stop(); // Stop the TTS engine
    super.dispose();
  }

  void _shareStory() {
    // Use the Share functionality from share_plus package
    Share.share(widget.story);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Story', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent, // Adjust the AppBar color to match the theme
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.pinkAccent,
                  Colors.blue,
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            reverse: false,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    widget.story,
                    style: GoogleFonts.comicNeue(
                      textStyle: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.white, // Ensures text is readable on the gradient background
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(Color(0xFFD66F23)),
                      elevation: WidgetStateProperty.all<double>(4),
                      shadowColor: WidgetStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Go back to the previous screen
                    },
                    child: const Text(
                      'Generate Another Story',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                      elevation: WidgetStateProperty.all<double>(4),
                      shadowColor: WidgetStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: _shareStory, // Share the story
                    child: const Text(
                      'Share Story',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!_isSpeaking) {
            await _flutterTts.setLanguage(_language);
            await _flutterTts.setSpeechRate(0.4); // Very slow rate
            await _flutterTts.setPitch(0.5);
            await _flutterTts.speak(widget.story);
            setState(() {
              _isSpeaking = true; // Update the speaking state
            });
          } else {
            await _flutterTts.stop(); // Stop the TTS engine
            setState(() {
              _isSpeaking = false; // Update the speaking state
            });
          }
        },
        child: _isSpeaking ? Icon(Icons.stop_rounded) : Icon(Icons.volume_up),
        backgroundColor: Colors.pinkAccent, // Adjust the FAB color to match the theme
      ),
    );
  }
}
