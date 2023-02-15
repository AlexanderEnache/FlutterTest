

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_test/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show CollectionReference, FirebaseFirestore;
import 'home.dart' show Home;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    // TemporaryMainPage()


    const MaterialApp(
      home: Home(title: "This is the title"),
      onGenerateRoute: RouteGenerator.generateRoute,
      // routes: {
      //   '/user_home_page' : (context) => const UserHomePage(title: "This is the title"),
      // }
    )
  );
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future:_fbApp,
        builder: (context, snapshot){
          if(snapshot.hasError){
            print('you have an error ${snapshot.error}');
            return MyHomePage(title: 'You have an ${snapshot.error}');
          }else if(snapshot.hasData){
            print('you have no errors');
            print(snapshot);
            print('you have no errors');
            return const MyHomePage(title: 'You have no error');
          }else{
            return const MyHomePage(title: 'You have no data');
          }
        }
      )
      // const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class TemporaryMainPage extends StatelessWidget{
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Text("Logged in");
        }else{
          return Text("Logged Out");
        }
      }

    )
  );
}

class ListTest extends StatelessWidget {

  ListTest({super.key});

  // FirebaseFirestore.instance.collection('users');
  // final FirebaseFirestore
  final Stream collectionStream = FirebaseFirestore.instance.collection('users').snapshots();
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Test"),
      ),
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
                      return Text("Hy my email is ${snap.docs[index]['email']}");
                    }
                  );
                }
              )
            ),
            Text("write data to firestore", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            MyCustomForm()
          ],
        )
      ),
    );
  }
}


class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  var email = '';

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.person),
            hintText: "What is your email",
            labelText: "Email"
          ),
          onChanged: (value) {
            email = value;
          },
          validator: (value) {
            if(value == null || value.isEmpty){
              return "Please enter some text";
            }
            return null;
          }),
          SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: (){
                if(_formKey.currentState!.validate()){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Sending Data to firestore'))
                  );
                  users.add({'email': email})
                  .then((value) => print("user added"))
                  .catchError((error) => {print(error)}
                  );
                }
              }, child: Text("Submit")
            )
          )
        ],
      )
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    // DatabaseReference _testRef = FirebaseData.instance.reference().child("test");

    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
