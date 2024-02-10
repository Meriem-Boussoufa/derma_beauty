import 'dart:convert';

import 'package:cosmetic_app/categorie_page.dart';
import 'package:cosmetic_app/product_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/categorymodel.dart';
import 'models/productmodel.dart';

List<dynamic> listsearch = [];
Future<List<ProductModel>> fetchData1() async {
  var response = await http
      .get(Uri.parse("http://192.168.1.103:3000/api/getSearchProduct/"));
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);
    for (int i = 0; i < jsonResponse.length; i++) {
      listsearch.add(jsonResponse[i]['nameProduct']);
    }
    return jsonResponse
        .map((products) => ProductModel.fromJson(products))
        .toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<List<CategoryModel>> fetchData() async {
  var response =
      await http.get(Uri.parse("http://192.168.1.103:3000/api/getCategory/"));
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body.toString());
    return jsonResponse
        .map((modelscategory) => CategoryModel.fromJson(modelscategory))
        .toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<CategoryModel>> futureData;
  final CategoryModel modelscategory = CategoryModel();
  late Future<List<ProductModel>> futureData1;
  final ProductModel products = ProductModel();
  @override
  void initState() {
    super.initState();
    futureData = fetchData();
    futureData1 = fetchData1();
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
            body:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          iconSize: 40,
                          color: Colors.black,
                          onPressed: () {
                            showSearch(
                                context: context,
                                delegate: DataSearch(list: listsearch));
                          }),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search ...',
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      contentPadding: const EdgeInsets.all(20),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      )),
                  onTap: (() {
                    showSearch(
                        context: context,
                        delegate: DataSearch(list: listsearch));
                  }),
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: SizedBox(
                  height: double.maxFinite,
                  child: FutureBuilder(
                      future: futureData,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<CategoryModel> categories = snapshot.data!;
                          if (snapshot.data!.isNotEmpty) {
                            return Flexible(
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: categories.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 300,
                                            height: 70,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) => CategoriePage(
                                                              name: categories[
                                                                      index]
                                                                  .namecategory
                                                                  .toString(),
                                                              idcategorie:
                                                                  categories[
                                                                          index]
                                                                      .idcategory
                                                                      .toString())));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color.fromRGBO(
                                                          243, 211, 204, 1.0),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        categories[index]
                                                            .namecategory
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          const SizedBox(height: 30),
                                        ]);
                                  }),
                            );
                          } else {
                            return const Text('No category');
                          }
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                ),
              ),
            ])));
  }
}

class DataSearch extends SearchDelegate<String> {
  late Future<List<ProductModel>> futureData;
  List<dynamic> list;

  DataSearch({required this.list});

  Future<List<ProductModel>> getsreachData() async {
    var response = await http.get(
      Uri.parse(
          "http://192.168.1.103:3000/api/getSearchProduct/searchBar?nameProduct=$query"),
    );
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((products) => ProductModel.fromJson(products))
          .toList();
    } else {
      throw Exception('Unexpected error occured !');
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = " ";
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, 'null');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var sreachlist =
        query.isEmpty ? list : list.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
        itemCount: sreachlist.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: const Icon(
              Icons.production_quantity_limits,
              color: Color.fromRGBO(203, 176, 189, 1),
            ),
            title: Text(sreachlist[i]),
            onTap: () {
              query = sreachlist[i];
              showResults(context);
            },
          );
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(203, 176, 189, 1),
      body: FutureBuilder(
        future: getsreachData(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 300,
                          height: 70,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ProductPage(
                                            id: snapshot.data![index].barcode
                                                .toString())));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(243, 211, 204, 1.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              child: Row(
                                children: [
                                  const Text('image'),
                                  Flexible(
                                    child: Text(
                                      snapshot.data![index].nameproduct
                                          .toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(height: 30),
                      ]);
                });
          }
          return Center(
            child: Column(
              children: const [
                SizedBox(height: 200),
                Icon(
                  Icons.search,
                  color: Color.fromRGBO(203, 176, 189, 1),
                  size: 80,
                ),
                SizedBox(height: 10),
                Text(
                  'NO PRODUCTS FOUND ',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
