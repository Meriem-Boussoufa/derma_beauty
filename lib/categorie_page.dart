import 'dart:convert';

import 'package:cosmetic_app/product_page.dart';
import 'package:cosmetic_app/searchfiltre_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/productmodel.dart';

Future<List<ProductModel>> fetchData(String id) async {
  var response = await http.get(Uri.parse(
      "http://192.168.1.103:3000/api/getCategory/getProductByCategory/$id"));
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body.toString());
    return jsonResponse
        .map((productsbycategory) => ProductModel.fromJson(productsbycategory))
        .toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class CategoriePage extends StatefulWidget {
  final String name;
  final String idcategorie;
  const CategoriePage(
      {super.key, required this.idcategorie, required this.name});

  @override
  // ignore: library_private_types_in_public_api
  _CategoriePageState createState() => _CategoriePageState();
}

class _CategoriePageState extends State<CategoriePage> {
  late Future<List<ProductModel>> futureData;
  final ProductModel productsbycategory = ProductModel();

  @override
  void initState() {
    super.initState();
    futureData = fetchData(widget.idcategorie);
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
              Flexible(
                child: Center(
                    child: Text(widget.name,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold))),
              ),
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
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                width: 250,
                height: 70,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => SearchFiltrePage(
                                  idcategory: widget.idcategorie,
                                  namecategory: widget.name)));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(243, 211, 204, 1.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(
                          'Filtrer la recherche ',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SizedBox(
                height: double.maxFinite,
                child: FutureBuilder(
                    future: futureData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        // ignore: unused_local_variable
                        List<ProductModel> productsbycategorie = snapshot.data!;
                        // ignore: unrelated_type_equality_checks
                        if (snapshot.data!.isNotEmpty) {
                          return Flexible(
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: productsbycategorie.length,
                                itemBuilder: (context, index) {
                                  var src =
                                      "https://a78e-105-110-223-214.eu.ngrok.io${productsbycategorie[index].pathimage?.trim()}";
                                  //print(src);
                                  return Flexible(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 370,
                                            height: 70,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) => ProductPage(
                                                                id: productsbycategorie[
                                                                        index]
                                                                    .barcode
                                                                    .toString())));
                                                  });
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
                                                  children: [
                                                    SizedBox(
                                                        height: 100,
                                                        width: 100,
                                                        child:
                                                            Image.network(src)),
                                                    Flexible(
                                                      child: Text(
                                                        productsbycategorie[
                                                                index]
                                                            .nameproduct
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          const SizedBox(height: 10),
                                        ]),
                                  );
                                }),
                          );
                        } else {
                          return const Text('No Products');
                        }
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ),
            ),
          ]),
        ));
  }
}
