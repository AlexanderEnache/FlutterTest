// import 'package:fl_test/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, FirebaseAuthException;


class Login extends StatefulWidget {
  const Login({super.key, required this.title});
  final String title;

  @override
  State<Login> createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  var password = '';
  var email = '';

  @override
  Widget build(BuildContext context) {
    Future signIn(email, passsword) async {
      showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator())
      );

      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException catch(e){
        print(e);
      }

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }

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
                    signIn(email.trim(), password.trim());
                  }
                },
              ),
            Container(
              child: const Text('Answer')
            ),
          ],
        ),
      )
    );
  }
}