import 'package:flutter/material.dart';
import 'package:story_land/features/screens/mobile/story_input_screen.dart';
import 'package:story_land/gen/assets.gen.dart';
import 'package:story_land/shared/dialog_utils.dart';

class MobileWelcomeScreen extends StatefulWidget {
  MobileWelcomeScreen({super.key});

  @override
  _MobileWelcomeScreenState createState() => _MobileWelcomeScreenState();
}

class _MobileWelcomeScreenState extends State<MobileWelcomeScreen> {
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
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.25,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "Welcome to story land",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Ensure the text is readable on the background
                      ),
                    ),
                    Text(
                      "where you get to create amazing stories",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.lerp(FontWeight.w200, FontWeight.bold, 20),
                        color: Colors.white, // Ensure the text is readable on the background
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "How old are you?",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white, // Ensure the text is readable on the background
                      ),
                    ),
                    SizedBox(height: 10),
                    DropdownButtonHideUnderline(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton<int>(
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
                          hint: Text('Select your age', style: TextStyle(color: Colors.brown)), // Ensure the hint text is readable
                          dropdownColor: Colors.white, // Dropdown background color
                          icon: Icon(Icons.arrow_drop_down, color: Colors.brown),
                          itemHeight: 50,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(Color(0xFFD66F23)),
                        elevation: WidgetStateProperty.all<double>(4), // Adjust the elevation as needed
                        shadowColor: WidgetStateProperty.all<Color>(Colors.black), // Optional: Specify the shadow color
                      ),
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
                      child: Text("Choose a category", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
