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

  MovieModel({
    this.backdropPath,
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
  });

  factory MovieModel.fromJson(Map<String, dynamic> map) {
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
        voteCount: map['vote_count'] ?? 0);
  }
}
