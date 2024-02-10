import 'package:cosmetic_app/home_page.dart';
import 'package:flutter/material.dart';

class OKPage extends StatefulWidget {
  final String email;
  const OKPage({
    super.key,
    required this.email,
  });

  @override
  // ignore: library_private_types_in_public_api
  _OKPageState createState() => _OKPageState();
}

bool isRegister = false;

class _OKPageState extends State<OKPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(203, 176, 189, 1),
              leading: IconButton(
                alignment: Alignment.centerLeft,
                icon: const Icon(Icons.arrow_back),
                color: Colors.black,
                iconSize: 30.0,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            backgroundColor: const Color.fromRGBO(203, 176, 189, 1),
            body: Column(
              children: [
                const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Registration completed',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                const Text('Thank you for registering',
                    style: TextStyle(fontStyle: FontStyle.italic)),
                const SizedBox(
                  height: 60,
                ),
                Center(
                  child: SizedBox(
                    width: 150,
                    height: 120,
                    child: Image.asset(
                      'assets/images/logo-removebg.png',
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      widget.email,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        isRegister = true;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => HomePage(
                                      logReg: isRegister,
                                    )));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(243, 211, 204, 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'OK',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      )),
                ),
              ],
            )));
  }
}
