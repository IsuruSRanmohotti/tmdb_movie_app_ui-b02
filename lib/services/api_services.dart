import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:tmdb_movie_app_ui/models/movie_model.dart';

class ApiServices {
  String popularMovies = "https://api.themoviedb.org/3/movie/popular";
  String topRatedMovies = "https://api.themoviedb.org/3/movie/top_rated";
  String upcomingMovies = "https://api.themoviedb.org/3/movie/upcoming";
  String movieDetails = "https://api.themoviedb.org/3/movie/";
  String apiKey = "?api_key=206f4bdc58a80317e550efddb30793aa";

  Future<List<MovieModel>> getPopularMovies() async {
    Response response = await get(Uri.parse("$popularMovies$apiKey"));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> results = body["results"];
      List<MovieModel> movies =
          results.map((movie) => MovieModel.fromJson(movie)).toList();

      return movies;
    } else {
      Logger().e(response.statusCode);
      return [];
    }
  }

  Future<List<MovieModel>> getTopRatedMovies() async {
    Response response = await get(Uri.parse("$topRatedMovies$apiKey"));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> results = body["results"];
      List<MovieModel> movies =
          results.map((movie) => MovieModel.fromJson(movie)).toList();
      return movies;
    } else {
      Logger().e(response.statusCode);
      return [];
    }
  }

  Future<List<MovieModel>> getUpcomingMovies() async {
    Response response = await get(Uri.parse("$upcomingMovies$apiKey"));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> results = body["results"];
      List<MovieModel> movies =
          results.map((movie) => MovieModel.fromJson(movie)).toList();
      return movies;
    } else {
      Logger().e(response.statusCode);
      return [];
    }
  }

  Future<MovieModel> getMovieDetails(String id) async {
    Response response = await get(Uri.parse("$movieDetails$id$apiKey"));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      MovieModel movie = MovieModel.fromJson(body);
      return movie;
    } else {
      return MovieModel();
    }
  }
}
