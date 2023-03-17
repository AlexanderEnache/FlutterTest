import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'ItemUPC.dart' show ItemUPC;
import 'foodImage.dart' show FoodImage;

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
      appBar: AppBar(
        title: Text(itemName),
      ),
      body:
        Center(child: 
          Column(children:
            <Widget>[
              FoodImage(photoLink: photoLink),
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

