import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

import 'models/compositionmodel.dart';
import 'models/problememodel.dart';
import 'models/productmodel.dart';

Future<ProductModel> fetchData(String id) async {
  var response =
      await http.get(Uri.parse("http://192.168.1.103:3000/api/getProduct/$id"));
  if (response.statusCode == 200) {
    final jsonresponse = jsonDecode(response.body);
    // print(jsonresponse); == []
    if (jsonresponse.length == 0) {
      return ProductModel();
    } else {
      return ProductModel.fromJson(jsonresponse);
    }
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<List<ProblemeModel>> fetchData1(String id) async {
  var response = await http
      .get(Uri.parse("http://192.168.1.103:3000/api/getProbleme/$id"));
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body.toString());
    return jsonResponse
        .map((modelsproducts) => ProblemeModel.fromJson(modelsproducts))
        .toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<List<CompositionModel>> fetchData2(String id) async {
  var response = await http
      .get(Uri.parse("http://192.168.1.103:3000/api/getComposition/$id"));
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body.toString());
    return jsonResponse
        .map((modelsproducts) => CompositionModel.fromJson(modelsproducts))
        .toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class ProductPage extends StatefulWidget {
  final String id;
  const ProductPage({super.key, required this.id});

  @override
  // ignore: library_private_types_in_public_api
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<ProductModel> futureData;
  final ProblemeModel modelsproducts = ProblemeModel();
  late Future<List<ProblemeModel>> futureData1;
  final CompositionModel modelscomposition = CompositionModel();
  late Future<List<CompositionModel>> futureData2;
  Widget getListProblems(List data) {
    String result = "";
    String sperator = ", ";
    for (var e in data) {
      if (data.last == e) {
        sperator = ". ";
      }
      result = result + e.nameprobleme.trim() + sperator;
    }
    return Text(' $result', style: const TextStyle(fontSize: 20));
  }

  @override
  void initState() {
    super.initState();
    futureData = fetchData(widget.id);
    futureData1 = fetchData1(widget.id);
    futureData2 = fetchData2(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(203, 176, 189, 1),
            title: Text(
              widget.id,
              style: const TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            leading: Flexible(
              // Leading for left side
              child: IconButton(
                alignment: Alignment.centerLeft,
                icon: const Icon(Icons.arrow_back),
                color: Colors.black,
                iconSize: 30.0,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          backgroundColor: const Color.fromRGBO(203, 176, 189, 1),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: FutureBuilder(
                future: futureData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.nameproduct != null) {
                      return Column(
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceAround, // 1 1 1
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Image.network(
                                        //http://localhost:4000
                                        "https://a78e-105-110-223-214.eu.ngrok.io${snapshot.data!.pathimage?.trim()}")),
                              ),
                              Flexible(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.nameproduct
                                            .toString()
                                            .trimRight(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      RatingBar.builder(
                                        itemSize: 25,
                                        initialRating: 3,
                                        minRating: 0,
                                        direction: Axis.horizontal,
                                        itemCount: 5,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ]),
                              ),
                              Column(children: [
                                IconButton(
                                  icon: const Icon(Icons.upload),
                                  iconSize: 35,
                                  onPressed: () {
                                    setState(() {
                                      //Navigator.push(context,MaterialPageRoute(builder: (_) =>  ) );
                                    });
                                  },
                                ),
                              ]),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    //Navigator.push(context,MaterialPageRoute(builder: (_) =>  ) );
                                  });
                                },
                                icon: const Icon(Icons.thumb_up),
                                color: const Color.fromARGB(255, 131, 8, 111),
                                iconSize: 30,
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    //Navigator.push(context,MaterialPageRoute(builder: (_) =>  ) );
                                  });
                                },
                                icon: const Icon(Icons.thumb_down_rounded),
                                color: const Color.fromARGB(255, 131, 8, 111),
                                iconSize: 30,
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    //Navigator.push(context,MaterialPageRoute(builder: (_) =>  ) );
                                  });
                                },
                                icon: const Icon(Icons.comment_rounded),
                                iconSize: 30,
                              )
                            ],
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Row(
                                children: [
                                  const Text(
                                    'Categorie : ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Flexible(
                                    child: Text(
                                        snapshot.data!.namecategorie.toString(),
                                        style: const TextStyle(fontSize: 20)),
                                  ),
                                ],
                              )),
                          Container(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Row(
                                children: [
                                  const Text('Type Peau : ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                  Flexible(
                                    child: Text(
                                        snapshot.data!.nametype.toString(),
                                        style: const TextStyle(fontSize: 20)),
                                  ),
                                ],
                              )),
                          Container(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 30),
                              child: Row(
                                children: [
                                  const Text('Probleme :',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                  // List of Problems :
                                  Flexible(
                                    child: SizedBox(
                                      child: Flexible(
                                        child:
                                            FutureBuilder<List<ProblemeModel>>(
                                                future: futureData1,
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return getListProblems(
                                                        snapshot.data as List);
                                                  } else {
                                                    return const Text(
                                                        'No problems');
                                                  }
                                                }),
                                      ),
                                    ),
                                  ),
                                ],
                              )),

                          const Center(
                            child: Text(
                              'Description :',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Center(
                              child: Text(
                                snapshot.data!.descproduct.toString(),
                              ),
                            ),
                          ),
                          const Center(
                            child: Text(
                              'Composition :',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          const SizedBox(height: 20),
                          //List des compositions
                          FutureBuilder(
                              future: futureData2,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<CompositionModel> compositions =
                                      snapshot.data!;
                                  return SizedBox(
                                    child: Flexible(
                                      child: ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: compositions.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 10, 5),
                                              child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  color: const Color.fromRGBO(
                                                      243, 211, 204, 1.0),
                                                  child: ExpansionTile(
                                                    textColor: Colors.black,
                                                    collapsedTextColor:
                                                        Colors.black,
                                                    iconColor: Colors.black,
                                                    collapsedIconColor:
                                                        Colors.black,
                                                    title: Text(
                                                      compositions[index]
                                                          .namecomposition
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    children: [
                                                      ListTile(
                                                        title: Text(
                                                          compositions[index]
                                                              .desccomposition
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 15),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            );
                                          }),
                                    ),
                                  );
                                } else {
                                  return const Text('No composition');
                                }
                              }),
                        ],
                      );
                    } else {
                      return const Center(
                          child: Text('Oups ! Product not found !!'));
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          ),
        ));
  }
}
