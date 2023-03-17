import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'ItemUPC.dart' show ItemUPC;

class FoodItem extends StatefulWidget {
  const FoodItem({super.key, required this.upc});
  final String upc;

  @override
  State<FoodItem> createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  final db = FirebaseFirestore.instance;
  var count = 0;
  var itemName = '';
  var photoLink = '';

  void initState() {
    super.initState();
    WidgetsBinding.instance
    .addPostFrameCallback((_) {
      setState(() {
        ItemUPC.getPhoto(widget.upc).then((value) {
          var data = value.split("***token***");
          setState(() {
            itemName = data[1];
            photoLink = data[0];
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Center(child: 
          Column(children:
            <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 70, bottom: 40),
                child: Text(itemName, style: TextStyle(fontSize: 22)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 30, left: 30, right: 30),
                child:Image(
                  image: NetworkImage(photoLink),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: (){
                    // ItemUPC.getPhoto(widget.upc);
                  }, child: const Text("+")),
                  Text(count.toString()),
                  ElevatedButton(onPressed: (){
                    // ItemUPC.getPhoto(widget.upc);
                  }, child: const Text("-")),
                ],
              ),
            ]
          )
        )
    );
  }
}

