import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final CollectionReference recipe =
      FirebaseFirestore.instance.collection('recipes');

  TextEditingController recipeTitle = TextEditingController();
  TextEditingController recipeDes = TextEditingController();
  TextEditingController recipeIngredients = TextEditingController();

  void addRecipe() {
    final data = {
      'title': recipeTitle.text,
      'des': recipeDes.text,
      'ingredients': recipeIngredients.text,
    };
    recipe.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Recipe'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: recipeTitle,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text('Recipe Title')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: recipeDes,
                keyboardType: TextInputType.multiline,
                maxLength: 50,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Recipe Description')),
                maxLines: 4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: recipeIngredients,
                keyboardType: TextInputType.multiline,
                maxLength: 100,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Recipe Ingredients')),
                maxLines: 5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  addRecipe();
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(double.infinity, 50),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
