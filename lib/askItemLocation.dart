import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException, FirebaseAuth;
import 'package:wheel_chooser/wheel_chooser.dart' show WheelChooser;

class AskItemLocation extends StatefulWidget {
  const AskItemLocation({super.key, required this.itemName, required this.upc});
  final String itemName;
  final String upc;

  @override
  State<AskItemLocation> createState() => _AskItemLocationState();
}

class _AskItemLocationState extends State<AskItemLocation> {
  final db = FirebaseFirestore.instance;
  late FixedExtentScrollController controller;
  List<String> locations = ["Fridge", "Garage"];

  void initState(){
    super.initState();
    controller = FixedExtentScrollController();
  }

  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future saveItem(location) async{
      showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator())
      );

      var item = <String, String>{
        "name": widget.itemName,
        "location": location,
        "upc": widget.upc,
        "amount": "2",
        "amount_unit": "units"
      };

      try{
        await db
        .collection("/houses").doc("house-${FirebaseAuth.instance.currentUser?.uid}")
        .collection("/house")
        .add(item).then((documentSnapshot) =>
          print("Added Data with ID: ${documentSnapshot.id}")
        ).onError((error, stackTrace) {
          print(error);
        }).then((value) {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      } on FirebaseAuthException catch(e){
        print(e);
      }
    }

    return Scaffold(
      body:
        WheelChooser(
          onValueChanged: (s) {
            print(s);
          },
          datas: locations,
          controller: controller,
          startPosition: null,
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          saveItem(locations[controller.selectedItem]);
        },
        child: const Text("+")
      ),
    );
  }
}

