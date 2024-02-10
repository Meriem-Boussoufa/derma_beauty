import 'dart:convert';

import 'package:cosmetic_app/home_page.dart';
import 'package:cosmetic_app/register_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<bool> verifyUSER(String username, String password) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.103:3000/api/postUser/user-login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, dynamic>{"nameUser": username, "passwordUser": password}),
  );
  if (response.statusCode == 200) {
    final jsonresponse = jsonDecode(response.body);
    return jsonresponse;
  } else {
    throw Exception('Failed to create USER.');
  }
}

class LogInPage extends StatefulWidget {
  const LogInPage({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _LogInPageState createState() => _LogInPageState();
}

bool isLogin = false;

class _LogInPageState extends State<LogInPage> {
  var myController0 = TextEditingController();
  var myController1 = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ScaffoldMessenger(
          key: scaffoldMessengerKey,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromRGBO(203, 176, 189, 1),
                title: const Text(
                  'Log in',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                leading: IconButton(
                  alignment: Alignment.centerLeft,
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black,
                  iconSize: 30.0,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              backgroundColor: const Color.fromRGBO(203, 176, 189, 1),
              body: SingleChildScrollView(
                child: Column(
                  children: [
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
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: myController0,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person,
                                color: Color.fromRGBO(243, 211, 204, 1.0)),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Username or email address',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            )),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: myController1,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color.fromRGBO(243, 211, 204, 1.0),
                            ),
                            suffixIcon: _obscureText
                                ? IconButton(
                                    icon: const Icon(Icons.visibility_off),
                                    color: const Color.fromRGBO(
                                        243, 211, 204, 1.0),
                                    onPressed: () => _toggle(),
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.visibility),
                                    color: const Color.fromRGBO(
                                        243, 211, 204, 1.0),
                                    onPressed: () => _toggle(),
                                  ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            )),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'Forget your password ?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                    SizedBox(
                      width: 250,
                      height: 60,
                      child: ElevatedButton(
                          onPressed: () async {
                            if ((myController0.text.isEmpty) &&
                                (myController1.text.isEmpty)) {
                              scaffoldMessengerKey.currentState
                                  ?.showSnackBar(const SnackBar(
                                content: Text('Please enter ur informations !'),
                              ));
                            } else {
                              if (await verifyUSER(
                                  myController0.text.toString(),
                                  myController1.text.toString())) {
                                isLogin = true;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => HomePage(
                                              logReg: isLogin,
                                            )));
                              } else {
                                scaffoldMessengerKey.currentState
                                    ?.showSnackBar(const SnackBar(
                                  content:
                                      Text('Password or Username incorrect !!'),
                                ));
                              }
                            }
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
                              Text(
                                'Log in',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(height: 70),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text('No account yet ? '),
                      InkWell(
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const RegisterPage()));
                        }),
                        child: const Text(
                          'Register',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ]),
                  ],
                ),
              )),
        ));
  }
}
