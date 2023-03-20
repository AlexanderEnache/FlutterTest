import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'foodList.dart' show FoodList;

class FridgePage extends StatefulWidget {
  const FridgePage({super.key});

  @override
  State<FridgePage> createState() => _FridgePageState();
}

class _FridgePageState extends State<FridgePage> {
  final Stream collectionStream = FirebaseFirestore.instance
  .collection('/houses')
  .doc("house-${FirebaseAuth.instance.currentUser?.uid}")
  .collection("/house")
  .snapshots();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page"),
      ),
      body:
        Center(child: 
          Column(children:
            const <Widget>[
              FoodList()
            ]
          )
        )
    );
  }
}
