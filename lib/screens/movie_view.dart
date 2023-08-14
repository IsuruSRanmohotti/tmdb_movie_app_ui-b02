import 'package:flutter/material.dart';
import 'package:tmdb_movie_app_ui/models/actors_model.dart';
import 'package:tmdb_movie_app_ui/models/company_model.dart';
import 'package:tmdb_movie_app_ui/models/genres_model.dart';
import 'package:tmdb_movie_app_ui/models/movie_model.dart';

import '../services/api_services.dart';

class MovieView extends StatefulWidget {
  const MovieView({super.key, required this.movie});
  final MovieModel movie;

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  List<CompanyModel> companies = [];
  List<GenresModel> genres = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: 170,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          NetworkImage(widget.movie.backdropPath.toString()))),
              child: const Stack(
                children: [
                  BackButton(
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.movie.title}",
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 24,
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
                            height: 176,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "${widget.movie.posterPath}"),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Text(
                          "${widget.movie.overview}",
                          textAlign: TextAlign.justify,
                        )),
                      ],
                    ),
                  ),
                  FutureBuilder(
                    future: ApiServices()
                        .getMovieDetails(widget.movie.id.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        MovieModel movie = snapshot.data!;
                        companies = movie.companies!;
                        genres = movie.genres!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const TitleText(text: "Tagline"),
                            Text(
                              movie.tagline.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade800),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const TitleText(text: "Production Companies"),
                            SizedBox(
                              height: 146,
                              child: ListView.builder(
                                itemCount: movie.companies!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 120,
                                      height: 130,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade700,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.network(
                                                movie.companies![index].logoPath
                                                            .toString() ==
                                                        ""
                                                    ? "https://cdn-icons-png.flaticon.com/512/2905/2905064.png"
                                                    : "https://image.tmdb.org/t/p/w500${movie.companies![index].logoPath.toString()}",
                                                width: 100,
                                                height: 100,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 4, left: 4, right: 4),
                                              child: Text(
                                                movie.companies![index].name
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const TitleText(text: "Genres"),
                            Wrap(
                              children: List.generate(
                                  movie.genres!.length,
                                  (index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 3, vertical: 3),
                                        child: Chip(
                                            label: Text(movie
                                                .genres![index].name
                                                .toString())),
                                      )),
                            )
                          ],
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                  const TitleText(text: "Cast"),
                  FutureBuilder(
                    future:
                        ApiServices().getActorsData(widget.movie.id.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ActorsModel>? actors = snapshot.data;
                        return Wrap(
                          children: List.generate(
                              actors!.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundImage: NetworkImage(actors[
                                                      index]
                                                  .image!
                                                  .isNotEmpty
                                              ? "https://image.tmdb.org/t/p/w500${actors[index].image.toString()}"
                                              : "https://cdn.pixabay.com/photo/2022/06/05/07/04/person-7243410_1280.png"),
                                        ),
                                        Text(actors[index].name.toString()),
                                        Text(
                                          actors[index].character.toString(),
                                          style: TextStyle(
                                              color: Colors.grey.shade500),
                                        )
                                      ],
                                    ),
                                  )),
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade700),
    );
  }
}
