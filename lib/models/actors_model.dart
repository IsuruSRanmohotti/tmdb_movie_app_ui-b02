class ActorsModel {
  String? image;
  String? name;
  String? character;

  ActorsModel({this.character, this.image, this.name});

  factory ActorsModel.fromJson(Map<String, dynamic> json) {
    return ActorsModel(
        character: json['character'] ?? "",
        image: json['profile_path'] ?? "",
        name: json['name'] ?? "");
  }
}
