import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateRecipe extends StatefulWidget {
  const UpdateRecipe({super.key});

  @override
  State<UpdateRecipe> createState() => _UpdateRecipeState();
}

class _UpdateRecipeState extends State<UpdateRecipe> {
  final CollectionReference task =
      FirebaseFirestore.instance.collection('recipes');

  TextEditingController recipeTitle = TextEditingController();
  TextEditingController recipeDes = TextEditingController();
  TextEditingController recipeIngredients = TextEditingController();

  // ignore: non_constant_identifier_names
  void UpdateRecipe(docId) {
    final data = {
      'title': recipeTitle.text,
      'des': recipeDes.text,
      'ingredients': recipeIngredients.text,
    };
    task.doc(docId).update(data).then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    recipeTitle.text = args['title'];
    recipeDes.text = args['des'];
    recipeIngredients.text = args['ingredients'];
    final docId = args['id'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Recipe'),
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
                    UpdateRecipe(docId);
                  },
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 50)),
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  child: const Text(
                    'Update',
                    style: TextStyle(fontSize: 20.0),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
