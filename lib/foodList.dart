import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

class FoodList extends StatefulWidget {

  const FoodList({super.key});

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  // FirebaseFirestore.instance.collection('users');
  final Stream collectionStream = FirebaseFirestore.instance
  .collection('/houses')
  .doc("house-${FirebaseAuth.instance.currentUser?.uid}")
  .collection("/house")
  .snapshots();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("List Test"),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Read Data From Firestore'),
            Container(
              height: 250,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: StreamBuilder(
                stream: collectionStream,
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.hasError){
                    print(snapshot.error);
                  }else if(snapshot.connectionState == ConnectionState.waiting){
                    return Text("Loading!!!");
                  }
                  final snap = snapshot.requireData;
                  return ListView.builder(
                    itemCount: snap.size,
                    itemBuilder: (context, index){
                      return Text("${snap.docs[index]['name']}");
                    }
                  );
                }
              )
            ),
            // Text("write data to firestore", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            // MyCustomForm()
          ],
        )
      ),
    );
  }
}
