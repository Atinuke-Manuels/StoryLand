import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_land/provider/story_provider.dart';
import 'package:story_land/shared/dialog_utils.dart';
import 'story_display_screen.dart';

class StoryInputScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController animalController = TextEditingController();
  final int selectedAge;


  StoryInputScreen({super.key, required this.selectedAge,});


  @override
  Widget build(BuildContext context) {
    // final int selectedAge = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Story Time',),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
              keyboardType: TextInputType.name,
            ),
            TextField(
              controller: animalController,
              decoration: InputDecoration(labelText: 'Favorite Animal'),
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Color(0xFFD66F23)),
                elevation: WidgetStateProperty.all<double>(4),
                shadowColor: WidgetStateProperty.all<Color>(Colors.black),
              ),
                onPressed: () async {
                  String name = nameController.text;
                  String animal = animalController.text;

                  if (name.isEmpty || animal.isEmpty) {
                    DialogUtils.showErrorDialog(context, 'did you just forget to write your name and favorite animal 🤔?');
                    return;
                  }

                  await context.read<StoryProvider>().fetchStory(selectedAge, name, animal);

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
              child: Text('Generate Story' ,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
    );
  }


}
