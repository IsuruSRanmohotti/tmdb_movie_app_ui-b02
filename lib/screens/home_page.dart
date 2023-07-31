import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_movie_app_ui/models/movie_model.dart';
import 'package:tmdb_movie_app_ui/screens/movie_view.dart';
import 'package:tmdb_movie_app_ui/services/api_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiServices service = ApiServices();
  List<MovieModel>? movies = [];
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  Text(
                    "TMDB Movies",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  Icon(
                    Icons.more_vert_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Container(
              width: screenSize.width * 0.9,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(50)),
              child: const Row(
                children: [
                  Expanded(
                      child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                        hintStyle: TextStyle(color: Colors.grey)),
                    style: TextStyle(color: Colors.white),
                  )),
                  Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: service.getPopularMovies(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  movies = snapshot.data;
                  return CarouselSlider(
                    options: CarouselOptions(height: 150, autoPlay: true),
                    items: movies!.map((movie) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.3),
                                        BlendMode.darken),
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        movie.backdropPath.toString())),
                                color: Colors.grey.shade800,
                                borderRadius: BorderRadius.circular(15)),
                            child: Stack(
                              children: [
                                Positioned(
                                    bottom: 5,
                                    left: 5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 1, horizontal: 8),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "${movie.voteAverage}",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 15,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Text(
                                          movie.title.toString(),
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.8),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 6),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Watch Now",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Icon(
                                            Icons.movie,
                                            color: Colors.white,
                                            size: 15,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Top Rated Movies",
                  style: TextStyle(
                      color: Colors.grey.shade200,
                      fontSize: 18,
                      fontWeight: FontWeight.w200),
                ),
              ),
            ),
            FutureBuilder(
              future: service.getTopRatedMovies(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<MovieModel> topRatedMovies = snapshot.data!;
                  return SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: topRatedMovies.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.2),
                                        BlendMode.darken),
                                    image: NetworkImage(topRatedMovies[index]
                                        .posterPath
                                        .toString()))),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: 55,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 1, horizontal: 8),
                                        child: Row(
                                          children: [
                                            Text(
                                              topRatedMovies[index]
                                                  .voteAverage
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: 120,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.amber.shade900,
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        topRatedMovies[index].title.toString(),
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Upcoming Movies",
                  style: TextStyle(
                      color: Colors.grey.shade200,
                      fontSize: 18,
                      fontWeight: FontWeight.w200),
                ),
              ),
            ),
            FutureBuilder(
              future: service.getUpcomingMovies(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<MovieModel> upcomingMovies = snapshot.data!;
                  return SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: upcomingMovies.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MovieView(movie: upcomingMovies[index]),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Hero(
                              tag: "${upcomingMovies[index].id}hero",
                              child: Container(
                                width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.2),
                                            BlendMode.darken),
                                        image: NetworkImage(
                                            upcomingMovies[index]
                                                .posterPath
                                                .toString()))),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          width: 55,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 1, horizontal: 8),
                                            child: Row(
                                              children: [
                                                Text(
                                                  upcomingMovies[index]
                                                      .voteAverage
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 15,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        width: 120,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.amber.shade900,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(15))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            upcomingMovies[index]
                                                .title
                                                .toString(),
                                            maxLines: 1,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return const CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}
