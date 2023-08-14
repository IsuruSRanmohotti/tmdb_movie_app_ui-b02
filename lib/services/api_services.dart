import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:tmdb_movie_app_ui/models/movie_model.dart';

import '../models/actors_model.dart';

class ApiServices {
  String popularMovies = "https://api.themoviedb.org/3/movie/popular";
  String topRatedMovies = "https://api.themoviedb.org/3/movie/top_rated";
  String upcomingMovies = "https://api.themoviedb.org/3/movie/upcoming";
  String movieDetails = "https://api.themoviedb.org/3/movie/";
  String searchMovie = "https://api.themoviedb.org/3/search/movie";
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

  Future<List<ActorsModel>> getActorsData(String id) async {
    Response response = await get(
        Uri.parse("https://api.themoviedb.org/3/movie/$id/credits$apiKey"));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> cast = body['cast'];
      List<ActorsModel> actors =
          cast.map((actor) => ActorsModel.fromJson(actor)).toList();
      return actors;
    } else {
      return [];
    }
  }

  Future<List<MovieModel>> searchMovies(String query) async {
    Response response =
        await get(Uri.parse("$searchMovie$apiKey&query=$query"));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> results = body["results"];
      List<MovieModel> movies =
          results.map((movie) => MovieModel.fromJson(movie)).toList();
      return movies;
    } else {
      throw response.statusCode;
    }
  }
}
