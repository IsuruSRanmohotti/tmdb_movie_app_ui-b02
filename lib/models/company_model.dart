class CompanyModel {
  String? name;
  String? logoPath;

  CompanyModel({this.logoPath, this.name});

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
        name: json['name'] ?? "Unknown", logoPath: json['logo_path'] ?? "");
  }
}
