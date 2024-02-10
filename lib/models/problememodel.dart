class ProblemeModel {
  final String? idprobleme;
  final String? nameprobleme;

  ProblemeModel({this.nameprobleme, this.idprobleme});

  factory ProblemeModel.fromJson(Map<String, dynamic> json) {
    return ProblemeModel(
      nameprobleme: json["nameProbleme"],
      idprobleme: json["idProbleme"],
    );
  }
}
