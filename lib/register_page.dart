import 'dart:convert';
import 'package:cosmetic_app/ok_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<bool> createUSER(String username, String email, String password) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.103:3000/api/postUser/user-register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "nameUser": username,
      "emailUser": email,
      "passwordUser": password
    }),
  );
  if (response.statusCode == 200) {
    final jsonresponse = jsonDecode(response.body);
    return jsonresponse;
  } else {
    throw Exception('Failed to create USER.');
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var myController = TextEditingController();
  var myController0 = TextEditingController();
  var myController1 = TextEditingController();
  bool valeur = false;

  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(203, 176, 189, 1),
            title: const Text(
              'Register',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                    controller: myController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person,
                            color: Color.fromRGBO(243, 211, 204, 1.0)),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Choose a username',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        )),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                  child: TextField(
                    controller: myController0,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email,
                            color: Color.fromRGBO(243, 211, 204, 1.0)),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'E-mail address',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        )),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                  child: TextFormField(
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
                                color: const Color.fromRGBO(243, 211, 204, 1.0),
                                onPressed: (() => _toggle()),
                              )
                            : IconButton(
                                icon: const Icon(Icons.visibility),
                                color: const Color.fromRGBO(243, 211, 204, 1.0),
                                onPressed: (() => _toggle()),
                              ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Password',
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        contentPadding: const EdgeInsets.all(10),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          checkColor: Colors.black,
                          activeColor: const Color.fromRGBO(243, 211, 204, 1.0),
                          value: valeur,
                          onChanged: ((bool? newValue) {
                            setState(() {
                              valeur = newValue!;
                            });
                          }),
                        ),
                        const Text(
                          'Accept the Terms of Service',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
                SizedBox(
                  width: 250,
                  height: 60,
                  child: ElevatedButton(
                      onPressed: () async {
                        if ((myController.text.isEmpty) &&
                            (myController0.text.isEmpty) &&
                            (myController1.text.isEmpty)) {
                          if (myController.text.isEmpty) {
                            scaffoldMessengerKey.currentState
                                ?.showSnackBar(const SnackBar(
                              content: Text('Please enter ur informations !'),
                            ));
                          }
                        } else {
                          if (await createUSER(
                              myController.text.toString(),
                              myController0.text.toString(),
                              myController1.text.toString())) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => OKPage(
                                          email: myController0.text.toString(),
                                        )));
                          } else {
                            scaffoldMessengerKey.currentState
                                ?.showSnackBar(const SnackBar(
                              content: Text('Account exist !!'),
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
                            'Registration',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          )),
    );
  }
}
