class GenresModel {
  String? name;

  GenresModel({this.name});

  factory GenresModel.fromJson(Map<String, dynamic> json) {
    return GenresModel(name: json['name']);
  }
}
