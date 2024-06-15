import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_land/features/screens/widgets/word_limit_input_formatter.dart';
import 'package:story_land/provider/story_provider.dart';
import 'package:story_land/shared/dialog_utils.dart';
import 'story_display_screen.dart';

class StoryInputScreen extends StatefulWidget {
  final int selectedAge;

  StoryInputScreen({super.key, required this.selectedAge});

  @override
  _StoryInputScreenState createState() => _StoryInputScreenState();
}

class _StoryInputScreenState extends State<StoryInputScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController keywordController = TextEditingController();
  String? selectedCategory;
  final List<String> categories = [
    '🐾 Animals',
    '🌸 Plants',
    '🌍 African Folklore',
    '🌙 Bedtime',
    '📖 Bible Story'
  ];
  String? nameError;
  String? keywordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Story Time', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        errorText: nameError,
                        errorStyle: TextStyle(color: Colors.white, fontSize: 12)),
                    style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      WordLimitInputFormatter(2)
                    ], // Limit to 2 words
                  ),
                  SizedBox(height: 20),
                  DropdownButtonHideUnderline(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: DropdownButton<String>(
                        value: selectedCategory,
                        hint: Text('Select a category'),
                        isExpanded: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCategory = newValue;
                          });
                        },
                        items: categories
                            .map<DropdownMenuItem<String>>((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        dropdownColor: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: keywordController,
                    decoration: InputDecoration(
                        labelText: 'Keyword',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        errorText: keywordError,
                        errorStyle: TextStyle(color: Colors.white, fontSize: 12)),
                    style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      WordLimitInputFormatter(2)
                    ], // Limit to 2 words
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD66F23)),
                      elevation: MaterialStateProperty.all<double>(4),
                      shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () async {
                      String name = nameController.text;
                      String keyword = keywordController.text;

                      // Reset error messages
                      nameError = null;
                      keywordError = null;

                      if (name.isEmpty || keyword.isEmpty || selectedCategory == null) {
                        if (name.isEmpty) {
                          nameError = 'Please enter your name.';
                        }
                        if (keyword.isEmpty) {
                          keywordError = 'Please enter a keyword like dog, flower, moonlight, Nigeria, Joseph';
                        }
                        if (selectedCategory == null) {
                          DialogUtils.showErrorDialog(context,
                              'Did you just forget to write your name, keyword or select a category 🤔?');
                        }
                        setState(() {});
                        return;
                      }

                      await context.read<StoryProvider>().fetchStory(
                          widget.selectedAge, name, keyword, selectedCategory!);

                      // Navigate to the story display screen
                      if (context.read<StoryProvider>().story != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StoryDisplayScreen(
                              story: context.read<StoryProvider>().story!,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Generate Story',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  Consumer<StoryProvider>(
                    builder: (context, storyProvider, child) {
                      if (storyProvider.isLoading) {
                        return CircularProgressIndicator();
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
