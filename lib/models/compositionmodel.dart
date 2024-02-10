class CompositionModel {
  final String? idcomposition;
  final String? namecomposition;
  final String? desccomposition;

  CompositionModel(
      {this.namecomposition, this.desccomposition, this.idcomposition});

  factory CompositionModel.fromJson(Map<String, dynamic> json) {
    return CompositionModel(
      namecomposition: json["nameComposition"],
      desccomposition: json["descComposition"],
      idcomposition: json["idComposition"],
    );
  }
}
