import 'package:fl_test/foodItem.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'foodItem.dart' show FoodItem;

class FoodList extends StatefulWidget {
  final String? title;

  const FoodList({super.key, this.title});
  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  final Stream collectionStream = FirebaseFirestore.instance
  .collection('/houses')
  .doc("house-${FirebaseAuth.instance.currentUser?.uid}")
  .collection("/house")
  .snapshots();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String? title = (widget.title ?? "");
    return SizedBox(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: (title == "" ? false : true),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(title)
              ),
            ),
            Container(
              height: 230,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(left:20, right:20, top:0, bottom:0),
                  child: StreamBuilder(
                  stream: collectionStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if(snapshot.hasError){
                      print(snapshot.error);
                    }else if(snapshot.connectionState == ConnectionState.waiting){
                      return const Text("Loading!!!");
                    }
                    final snap = snapshot.requireData;
                    return ListView.builder(
                      itemCount: snap.size,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.only(left:0, right:0, top:0, bottom:0),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: <Widget>[
                              Flexible(
                                flex: 4,
                                fit:FlexFit.tight,
                                child:
                                TextButton(
                                    style: TextButton.styleFrom(
                                      padding:  const EdgeInsets.all(0),
                                      alignment: Alignment.centerLeft
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => FoodItem(upc: snap.docs[index]['upc'])),
                                      );
                                    },
                                    child: Text("${snap.docs[index]['name']}", style: const TextStyle(color:Colors.white)),
                                )
                              ),
                              Flexible(
                                flex: 1,
                                fit:FlexFit.tight,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      padding:  const EdgeInsets.all(0),
                                      alignment: Alignment.center,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => FoodItem(upc: snap.docs[index]['upc'])),
                                      );
                                    },
                                    child: Text("${snap.docs[index]['amount']}", style: const TextStyle(color:Colors.white, fontWeight: FontWeight.normal)),
                                )
                              ),
                              Flexible(
                                flex: 1,
                                fit:FlexFit.tight,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      padding:  const EdgeInsets.all(0),
                                      alignment: Alignment.centerRight
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => FoodItem(upc: snap.docs[index]['upc'])),
                                      );
                                    },
                                    child:Text("${snap.docs[index]['amount_unit']}", style: const TextStyle(color:Colors.white, fontWeight: FontWeight.normal)),
                                )
                              )
                            ]
                          )
                        );
                      }
                    );
                  }
                )
              ),
            )
          ],
        )
      ),
    );
  }
}
