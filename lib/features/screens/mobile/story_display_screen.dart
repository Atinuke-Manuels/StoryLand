import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tts/flutter_tts.dart';

class StoryDisplayScreen extends StatefulWidget {
  final String story;

  const StoryDisplayScreen({super.key, required this.story});

  @override
  _StoryDisplayScreenState createState() => _StoryDisplayScreenState();
}

class _StoryDisplayScreenState extends State<StoryDisplayScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  String _language = 'en-US';
  bool _isSpeaking = false; // new variable to track the speaking state

  //to ensure the tts method is disposed when the widget is no longer in focus.
  @override
  void dispose() {
    _flutterTts.stop(); // stop the TTS engine
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Story'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        reverse: false,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(widget.story, style: GoogleFonts.comicNeue(
                textStyle: const TextStyle(
                  fontSize: 18.0,
                ),
              ),),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Color(0xFFD66F23)),
                  elevation: WidgetStateProperty.all<double>(4), // Adjust the elevation as needed
                  shadowColor: WidgetStateProperty.all<Color>(Colors.black), // Optional: Specify the shadow color
                ),
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous screen
                },
                child: const Text('Generate Another Story', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!_isSpeaking) {
            await _flutterTts.setLanguage(_language);
            await _flutterTts.setSpeechRate(0.4); // very slow rate
            await _flutterTts.setPitch(0.5);
            await _flutterTts.speak(widget.story);
            setState(() {
              _isSpeaking = true; // update the speaking state
            });
          } else {
            await _flutterTts.stop(); // stop the TTS engine
            setState(() {
              _isSpeaking = false; // update the speaking state
            });
          }
        },
        child: _isSpeaking ? Icon(Icons.stop_rounded) : Icon(Icons.volume_up),
      ),
    );
  }
}