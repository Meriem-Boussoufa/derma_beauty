import 'package:cosmetic_app/login_page.dart';
import 'package:flutter/material.dart';

class AuthentificationPage extends StatefulWidget {
  const AuthentificationPage({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AuthentificationPageState createState() => _AuthentificationPageState();
}

class _AuthentificationPageState extends State<AuthentificationPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(203, 176, 189, 1),
            title: const Text(
              'Derma Beauty',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: IconButton(
              alignment: Alignment.centerLeft,
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
              iconSize: 30.0,
              onPressed: () => Navigator.pop(context),
            ),
          ),
          backgroundColor: const Color.fromRGBO(203, 176, 189, 1),
          body: Column(children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                width: 150,
                height: 150,
                child: Image.asset(
                  'assets/images/logo-removebg.png',
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Column(
              children: [
                SizedBox(
                  width: 250,
                  height: 70,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LogInPage()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(243, 211, 204, 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            'Sign In / Sign Up',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('or'),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 250,
                  height: 70,
                  child: ElevatedButton(
                      onPressed: () async {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset('assets/images/google.png'),
                          const Text(
                            'Sign In',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ]),
        ));
  }
}
