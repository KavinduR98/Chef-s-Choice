import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lab_assessment/screens/add_recipe.dart';
import 'package:lab_assessment/screens/splash.dart';
import 'package:lab_assessment/screens/update_recipe.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapShot) {
          // Check for Errors
          if (snapShot.hasError) {
            print("Something Went Wrong");
          }
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return MaterialApp(
            title: "Recipe App with Firebase Authentication",
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (context) => const Splash(),
              '/add': (context) => const AddRecipe(),
              '/update': (context) => const UpdateRecipe(),
            },
            initialRoute: '/',
          );
        });
  }
}
