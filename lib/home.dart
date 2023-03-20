import 'package:fl_test/fridgePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:http/http.dart' as http;
import 'ItemUPC.dart' show ItemUPC;
import 'askItemLocation.dart' show AskItemLocation;
import 'foodList.dart' show FoodList;

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  static const IconData qr_code_scanner_rounded = IconData(0xf00cc, fontFamily: 'MaterialIcons');

  Future<dynamic> searchUPC() async{
    var url = Uri.parse('https://trackapi.nutritionix.com/v2/search/item?x-app-id=319c0339&x-app-key=f86cb82b0bdbc3decd5168012b49f746&upc=8901161124463');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  @override
  Widget build(BuildContext context) {
    _scan() async {
      await FlutterBarcodeScanner.scanBarcode("#000000", "Cancel", false, ScanMode.BARCODE)
      .then((value) async{
        setState(()=>qrCode = value);
        ItemUPC.getUPC(qrCode).then((value) {
          print(qrCode);
          print(value);
          Navigator.push(context, MaterialPageRoute(builder: (context) => AskItemLocation(itemName: value, upc: qrCode)));
        });
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('fridge'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FridgePage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: 
        Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text('Press to Scan')
            ),
            SizedBox( 
              height:100, //height of button
              width:100, //width of button
              child:  ElevatedButton(
                onPressed: () => _scan(), child: const Icon(qr_code_scanner_rounded)
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0)
            ),
            const FoodList(title: "Last Scans")
          ],
        ),
      )
    );
  }
}

