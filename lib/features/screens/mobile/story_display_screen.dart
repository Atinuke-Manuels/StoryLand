import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StoryDisplayScreen extends StatelessWidget {
  final String story;

  const StoryDisplayScreen({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Story'),
      ),
      body: SingleChildScrollView(
        reverse: false,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(story, style: GoogleFonts.comicNeue(
                textStyle: const TextStyle(
                  fontSize: 18.0,
                ),
              ),),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous screen
                },
                child: const Text('Generate Another Story'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.volume_up),
      ),
    );
  }
}
