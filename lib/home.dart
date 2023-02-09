import 'package:flutter/material.dart';
import 'package:fl_test/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show CollectionReference, FirebaseFirestore;

class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          TextButton(onPressed: (){
            Navigator.of(context).pushNamed('/login');
          }, child: const Text("Login"))
          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }
}
