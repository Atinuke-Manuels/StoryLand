import 'package:flutter/material.dart';
import 'package:story_land/features/screens/mobile/story_input_screen.dart';
import 'package:story_land/gen/assets.gen.dart';
import 'package:story_land/shared/dialog_utils.dart';

class DesktopTabletWelcomeScreen extends StatefulWidget {
  const DesktopTabletWelcomeScreen({super.key});

  @override
  State<DesktopTabletWelcomeScreen> createState() => _DesktopTabletWelcomeScreenState();
}

class _DesktopTabletWelcomeScreenState extends State<DesktopTabletWelcomeScreen> {
  int? selectedAge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.pinkAccent,
                      Colors.blue
                    ]
                )
            ),
          ),
          // Main content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                reverse: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        Assets.background.path,
                        width: 500,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "Welcome to story land",
                      style: TextStyle(
                        fontSize: 46,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Ensure the text is readable on the background
                      ),
                    ),
                    Text(
                      "where you get to create amazing stories",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.lerp(FontWeight.w200, FontWeight.bold, 20),
                        color: Colors.white, // Ensure the text is readable on the background
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "How old are you?",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white, // Ensure the text is readable on the background
                      ),
                    ),
                    SizedBox(height: 10),
                    DropdownButton<int>(
                      value: selectedAge,
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedAge = newValue;
                        });
                      },
                      items: List<DropdownMenuItem<int>>.generate(
                        16,
                            (int index) => DropdownMenuItem<int>(
                          value: index,
                          child: Text(index.toString(),
                            style: TextStyle( fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      hint: Text('Select your age', style: TextStyle(color: Colors.white)), // Ensure the hint text is readable
                      dropdownColor: Colors.white, // Dropdown background color
                      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                      itemHeight: 50,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedAge != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StoryInputScreen(selectedAge: selectedAge!),
                            ),
                          );
                        } else {
                          DialogUtils.showErrorDialog(context, 'Seems you forgot to select your age!!! 🎂');
                        }
                      },
                      child: Text("Choose a category"),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
