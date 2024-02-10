import 'package:cosmetic_app/afterauthentification_page.dart';
import 'package:cosmetic_app/authentification_page.dart';
import 'package:cosmetic_app/product_page.dart';
import 'package:cosmetic_app/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomePage extends StatefulWidget {
  final bool logReg;
  const HomePage({super.key, required this.logReg});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? scanResult;

  Future scanqr() async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          '#2A99CF', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      scanResult = 'Failed to scann ';
    }
    setState(() {
      this.scanResult = scanResult;
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => ProductPage(id: scanResult)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Stack(children: <Widget>[
          Flexible(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
              width: 500,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                    child: Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.settings),
                            iconSize: 40,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 50,
                            child: CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 30,
                                child: widget.logReg
                                    ? IconButton(
                                        icon: const Icon(Icons.alarm),
                                        color: const Color.fromRGBO(
                                            243, 211, 204, 1.0),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const AfterAuthentificationPage()));
                                          });
                                        })
                                    : IconButton(
                                        icon: const Icon(Icons.person),
                                        color: const Color.fromRGBO(
                                            243, 211, 204, 1.0),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const AuthentificationPage()));
                                          });
                                        })),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(30, 70, 30, 50),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 90, vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(203, 176, 189, 0.7),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                          child: Text(
                            'WELCOME',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.asset(
                            'assets/images/logo-removebg.png',
                            //color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    height: 70,
                    child: ElevatedButton(
                        onPressed: () async {
                          scanqr();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(243, 211, 204, 1.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Icon(
                              Icons.qr_code_scanner,
                              color: Colors.black,
                              size: 40,
                            ),
                            Text(
                              'Scan a product',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        )),
                  ),
                  /*Text(scanResult == null
                          ? 'Scan code'
                          : 'Scan result : $scanResult'),*/
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 250,
                    height: 70,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SearchPage()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(243, 211, 204, 1.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 40,
                            ),
                            Text(
                              'Search for a product',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 250,
                    height: 70,
                    child: ElevatedButton(
                        onPressed: () {
                          /* Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ));*/
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(243, 211, 204, 1.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.black,
                              size: 40,
                            ),
                            Text(
                              'Nearby Cosmetics',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ])));
  }
}
