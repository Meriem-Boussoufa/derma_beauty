import 'package:flutter/material.dart';

class AfterAuthentificationPage extends StatefulWidget {
  const AfterAuthentificationPage({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AfterAuthentificationPageState createState() =>
      _AfterAuthentificationPageState();
}

class _AfterAuthentificationPageState extends State<AfterAuthentificationPage> {
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
              children: [],
            )));
  }
}
