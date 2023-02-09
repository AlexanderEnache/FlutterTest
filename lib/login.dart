import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show CollectionReference, FirebaseFirestore, Query, QuerySnapshot;
import 'package:fl_test/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart'
import 'firebase_options.dart';


class Login extends StatefulWidget {
  const Login({super.key, required this.title});
  final String title;

  @override
  State<Login> createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  // final query = FirebaseFirestore.instance.collection('users').where("state", isEqualTo: "CA").get();

  var password = '';
  var email = '';

  @override
  Widget build(BuildContext context) {
    print("collection ----- Stream");
    // print(query);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(validator: (value) {
                if(value == null || value.isEmpty){
                  return 'not NUll';
                }else{
                  return null;
                }
              },
              onChanged: (value) {
                email = value;
              },
            ),
            TextFormField(validator: (value) {
                if(value == null || value.isEmpty){
                  return 'not NUll';
                }else{
                  return null;
                }
              },
              onChanged: (value) {
                password = value;
              },
            ),
            ElevatedButton(
                child: const Text("Validate"),
                onPressed: () {
                  if(_formKey.currentState!.validate()){
                    final Future<QuerySnapshot<Map<String, dynamic>>> query = 
                    FirebaseFirestore.instance.collection('users').
                    where("email", isEqualTo: "email@email.com").get().
                    then(
                      (res) {
                        print("Successfully completed"); 
                        print( res.docs.first.data()['email']);
                        
                       


                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Great'))
                        );

                        return res;
                      },
                      onError: (e) => print("Error completing: $e"),
                    );

                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('Great'))
                    // );
                  }
                },
              ),
            Container(
              child: const Text('Answer')
            ),

            // Container(
            //   height: 250,
            //   padding: const EdgeInsets.symmetric(vertical: 20),
            //   child: StreamBuilder(
            //     stream: collectionStream,
            //     builder: (BuildContext context, AsyncSnapshot snapshot){
            //       if(snapshot.hasError){
            //         print(snapshot.error);
            //       }else if(snapshot.connectionState == ConnectionState.waiting){
            //         return Text("Loading!!!");
            //       }
            //       final snap = snapshot.requireData;
            //       return ListView.builder(
            //         itemCount: snap.size,
            //         itemBuilder: (context, index){
            //           return Text("Hy my email is ${snap.docs[index]['email']}");
            //         }
            //       );
            //     }
            //   )
            // ),
          ],
        ),
      )
    );
  }
}