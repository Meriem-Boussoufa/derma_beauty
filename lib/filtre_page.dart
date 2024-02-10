import 'dart:convert';

import 'package:cosmetic_app/models/productmodel.dart';
import 'package:cosmetic_app/product_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<ProductModel>> fetchData(
    String idcat, String idtype, String element) async {
  var response = await http.get(Uri.parse(
      "http://192.168.1.103:3000/api/getProduct/$idcat/$idtype/$element"));
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body.toString());
    return jsonResponse
        .map((products) => ProductModel.fromJson(products))
        .toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class FiltrePage extends StatefulWidget {
  final String idcat;
  final String idtype;
  final String namecat;
  final List<int> ids;
  const FiltrePage({
    super.key,
    required this.idcat,
    required this.idtype,
    required this.namecat,
    required this.ids,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FiltrePageState createState() => _FiltrePageState();
}

class _FiltrePageState extends State<FiltrePage> {
  late Future<List<ProductModel>> futureData;
  final ProductModel products = ProductModel();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.ids.length; i++) {
      var element = widget.ids.elementAt(i).toString();
      futureData = fetchData(widget.idcat, widget.idtype, element);
    }
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
                        child: Text(
                  widget.namecat,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ))),
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
            body: Column(
              children: [
                const SizedBox(height: 20),
                FutureBuilder(
                  future: futureData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // ignore: unused_local_variable
                      List<ProductModel> products = snapshot.data!;
                      if (snapshot.data!.isNotEmpty) {
                        return Flexible(
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: products.length,
                                itemBuilder: ((context, index) {
                                  var src =
                                      "https://a78e-105-110-223-214.eu.ngrok.io${products[index].pathimage?.trim()}";
                                  //print(src);
                                  return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                          builder: (_) =>
                                                              ProductPage(
                                                                  id: products[
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
                                                      products[index]
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
                                        const SizedBox(height: 5),
                                      ]);
                                })));
                      } else {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Sorry No products ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Icon(Icons.sentiment_dissatisfied_sharp),
                            ]);
                      }
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ],
            )));
  }
}
