import 'package:flutter/material.dart';
import 'package:tmdb_movie_app_ui/models/movie_model.dart';

import '../services/api_services.dart';

class MovieView extends StatefulWidget {
  const MovieView({super.key, required this.movie});
  final MovieModel movie;

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: size.width,
            height: 170,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.movie.backdropPath.toString()))),
            child: const Stack(
              children: [
                BackButton(
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Text(
            "${widget.movie.title}",
            style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Hero(
                  tag: "${widget.movie.id}hero",
                  child: Container(
                    width: 120,
                    height: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey,
                        image: DecorationImage(
                            image: NetworkImage("${widget.movie.posterPath}"),
                            fit: BoxFit.cover)),
                  ),
                )
              ],
            ),
          ),
          Text("${widget.movie.overview}"),
          FutureBuilder(
            future: ApiServices().getMovieDetails(widget.movie.id.toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                MovieModel movie = snapshot.data!;
                return Text(movie.tagline.toString());
              }
              return const CircularProgressIndicator();
            },
          )
        ],
      ),
    );
  }
}
