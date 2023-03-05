import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_assessment/screens/login.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final CollectionReference recipe =
      FirebaseFirestore.instance.collection('recipes');

  void deleteRecipe(docId) {
    recipe.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: AppBar(
            title: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text('Chef’s Choice'),
                const SizedBox(
                  width: 220,
                ),
                IconButton(
                    onPressed: () async => {
                          await FirebaseAuth.instance.signOut(),
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Login(),
                              ),
                              (route) => false)
                        },
                    icon: const Icon(Icons.logout))
              ],
            ),
            backgroundColor: Colors.green,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          size: 40.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
        stream: recipe.orderBy('title').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot recipeSnap = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 80.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 233, 233, 233),
                            blurRadius: 10.0,
                            spreadRadius: 15.0,
                          )
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                recipeSnap['title'],
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                recipeSnap['des'],
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/update',
                                    arguments: {
                                      'title': recipeSnap['title'],
                                      'des': recipeSnap['des'],
                                      'ingredients': recipeSnap['ingredients'],
                                      'id': recipeSnap.id,
                                    });
                              },
                              icon: const Icon(Icons.edit),
                              iconSize: 30.0,
                              color: Colors.blue[200],
                            ),
                            IconButton(
                              onPressed: () {
                                deleteRecipe(recipeSnap.id);
                              },
                              icon: const Icon(Icons.delete),
                              iconSize: 30.0,
                              color: Colors.red,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
