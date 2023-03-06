import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:http/http.dart' as http;
import 'ItemUPC.dart' show ItemUPC;
import 'askItemLocation.dart' show AskItemLocation;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(key: key, title: "Home")
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  String qrCode = "default";
  final db = FirebaseFirestore.instance;
  ItemUPC upc = ItemUPC();

  _scan() async {
    await FlutterBarcodeScanner.scanBarcode("#000000", "Cancel", false, ScanMode.BARCODE)
      .then((value) async{
        setState(()=>qrCode = value);
        
        upc.getUPC(qrCode).then((value) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AskItemLocation(itemName: value, upc: qrCode)));
        });
    });
  }

  Future<dynamic> searchUPC() async{
    var url = Uri.parse('https://trackapi.nutritionix.com/v2/search/item?x-app-id=319c0339&x-app-key=f86cb82b0bdbc3decd5168012b49f746&upc=8901161124463');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          TextButton(onPressed: () async =>setState(()=>qrCode = _scan()), child: const Text("Scan")),
          TextButton(onPressed: (){
            FirebaseAuth.instance.signOut();
          }, child: const Text("Log Out"))
        ],
      ),
    );
  }
}
