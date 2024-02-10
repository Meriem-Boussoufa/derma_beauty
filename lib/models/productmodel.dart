class ProductModel {
  final String? barcode;
  final String? nameproduct;
  final String? descproduct;
  final String? pathimage;
  final String? namecategorie;
  final String? nametype;

  ProductModel({
    this.barcode,
    this.nameproduct,
    this.descproduct,
    this.pathimage,
    this.namecategorie,
    this.nametype,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      barcode: json["barCode"],
      nameproduct: json["nameProduct"],
      descproduct: json["descProduct"],
      pathimage: json["pathimage"],
      namecategorie: json["nameCategory"],
      nametype: json["nameTypePeau"],
    );
  }
}
