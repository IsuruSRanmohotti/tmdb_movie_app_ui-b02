import 'package:logger/logger.dart';
import 'package:tmdb_movie_app_ui/models/company_model.dart';
import 'package:tmdb_movie_app_ui/models/genres_model.dart';

class MovieModel {
  String? backdropPath;
  int? id;
  String? posterPath;
  String? title;
  double? voteAverage;
  String? overview;
  bool? adult;
  int? budget;
  String? tagline;
  int? voteCount;
  String? status;
  List<CompanyModel>? companies;
  List<GenresModel>? genres;

  MovieModel(
      {this.backdropPath,
      this.id,
      this.posterPath,
      this.title,
      this.voteAverage,
      this.overview,
      this.adult,
      this.budget,
      this.status,
      this.tagline,
      this.voteCount,
      this.companies,
      this.genres});

  factory MovieModel.fromJson(Map<String, dynamic> map) {
    List<CompanyModel> companies = [];
    List<GenresModel> genres = [];

    if (map.containsKey("production_companies")) {
      companies = (map['production_companies'] as List)
          .map((company) => CompanyModel.fromJson(company))
          .toList();
      genres = (map['genres'] as List)
          .map((genre) => GenresModel.fromJson(genre))
          .toList();
    }

    return MovieModel(
        backdropPath: "https://image.tmdb.org/t/p/w500${map["backdrop_path"]}",
        id: map["id"],
        posterPath: "https://image.tmdb.org/t/p/w500${map["poster_path"]}",
        title: map["title"],
        voteAverage: map["vote_average"].toDouble(),
        overview: map["overview"],
        adult: map["adult"] == null ? false : map['adult'],
        budget: map["budget"] ?? 0,
        status: map['status'] ?? "",
        tagline: map['tagline'] ?? "",
        voteCount: map['vote_count'] ?? 0,
        companies: companies,
        genres: genres);
  }
}
