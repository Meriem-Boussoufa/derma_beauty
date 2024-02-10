import 'dart:convert';

import 'package:cosmetic_app/filtre_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/problememodel.dart';
import 'models/typemodel.dart';

Future<List<TypeModel>> fetchData() async {
  var response =
      await http.get(Uri.parse("http://192.168.1.103:3000/api/getType/"));
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body.toString());
    return jsonResponse
        .map((modelstypes) => TypeModel.fromJson(modelstypes))
        .toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<List<ProblemeModel>> fetchData1() async {
  var response =
      await http.get(Uri.parse("http://192.168.1.103:3000/api/getProbleme/"));
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body.toString());
    return jsonResponse
        .map((modelsproblems) => ProblemeModel.fromJson(modelsproblems))
        .toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class SearchFiltrePage extends StatefulWidget {
  final String idcategory;
  final String namecategory;
  const SearchFiltrePage(
      {super.key, required this.idcategory, required this.namecategory});

  @override
  // ignore: library_private_types_in_public_api
  _SearchFiltrePageState createState() => _SearchFiltrePageState();
}

class _SearchFiltrePageState extends State<SearchFiltrePage> {
  late Future<List<TypeModel>> futureData;
  final TypeModel modelstypes = TypeModel();

  late Future<List<ProblemeModel>> futureData1;
  final ProblemeModel modelsproblems = ProblemeModel();
  @override
  void initState() {
    super.initState();
    futureData = fetchData();
    futureData1 = fetchData1();
  }

  int selectedRadio = 0;
  bool isSelected = false;
  setSlectedRadio(val) {
    setState(() {
      selectedRadio = val;
    });
  }

  List<bool> itemsChecked = [];
  List<int> idproblems = [];

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Please enter type of ur skin and probleme skin.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OKAY '),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                alignment: Alignment.centerLeft,
                icon: const Icon(Icons.arrow_back),
                color: Colors.black,
                iconSize: 30.0,
                onPressed: () => Navigator.pop(context),
              ),
              const Flexible(child: Center(child: Text(''))),
              IconButton(
                icon: const Icon(Icons.notifications),
                color: Colors.black,
                iconSize: 30.0,
                onPressed: () => Navigator.pop(context),
              ),
            ],
            backgroundColor: const Color.fromRGBO(203, 176, 189, 1),
          ),
          backgroundColor: const Color.fromRGBO(203, 176, 189, 1),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 130,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          if ((selectedRadio == 0) && (idproblems.isEmpty)) {
                            _showMyDialog();
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => FiltrePage(
                                          idcat: widget.idcategory,
                                          idtype: selectedRadio.toString(),
                                          namecat: widget.namecategory,
                                          ids: idproblems,
                                        )));
                          }
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
                              'Search',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 130,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
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
                              'Skip',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Type de la peau :',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              FutureBuilder(
                  future: futureData,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      List<TypeModel> types = snapshot.data!;
                      return SizedBox(
                        child: Flexible(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: types.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    RadioListTile(
                                        title: Text(
                                          types[index].nameType.toString(),
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                        value: int.parse(
                                            types[index].idType.toString()),
                                        groupValue: selectedRadio,
                                        activeColor: Colors.black87,
                                        onChanged: (val) {
                                          setState(() {
                                            setSlectedRadio(val);
                                            isSelected = true;
                                          });
                                        },
                                        // ignore: unrelated_type_equality_checks
                                        selected: selectedRadio ==
                                            int.parse(types[index]
                                                .idType
                                                .toString())),
                                  ],
                                );
                              }),
                        ),
                      );
                    } else {
                      return const Text('no types');
                    }
                  })),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Problème de la peau :',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              FutureBuilder(
                  future: futureData1,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ProblemeModel> problems = snapshot.data!;
                      for (int i = 0; i < problems.length; i++) {
                        itemsChecked.add(false);
                      }
                      return SizedBox(
                        child: Flexible(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: problems.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    CheckboxListTile(
                                      title: Text(
                                        problems[index].nameprobleme.toString(),
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      value: itemsChecked[index],
                                      checkColor: Colors.white,
                                      activeColor: Colors.black,
                                      onChanged: (newValue) {
                                        setState(() {
                                          if (newValue!) {
                                            idproblems.add(int.parse(
                                                problems[index]
                                                    .idprobleme
                                                    .toString()));
                                          } else {
                                            idproblems.remove(int.parse(
                                                problems[index]
                                                    .idprobleme
                                                    .toString()));
                                          }
                                          itemsChecked[index] = newValue;
                                          print(idproblems);
                                        });
                                      },
                                      selected: itemsChecked[index],
                                    )
                                  ],
                                );
                              }),
                        ),
                      );
                    } else {
                      return const Text('no problems');
                    }
                  }),
            ]),
          ),
        ));
  }
}
