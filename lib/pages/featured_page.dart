import 'package:flutter/material.dart';

import '../models/movie_model.dart';
import '../services/MovieService.dart';
import '../services/UserService.dart';
import 'movie_info_page.dart';

class FeaturedPage extends StatefulWidget {
  const FeaturedPage({super.key});

  @override
  State<FeaturedPage> createState() => _FeaturedPageState();
}

class _FeaturedPageState extends State<FeaturedPage> {
  List<Movie> movieList = [];

  void reloadPageCallback() {
    setState(() {
      loadMovies();
    });
  }
  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    UserService userService = UserService();
    String userKey = await userService.getUserKey();
    List<int> favorites = await userService.getListOfFavourites(userKey);
    if(favorites.isNotEmpty) {
      MovieService movieService = MovieService(favorites);
      List<Movie> items = await movieService.getMovies();
      setState(() {
        movieList = items;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(movieList[index].title,
                style: const TextStyle(
                    fontSize: 20
                )),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context){
                    return MovieInfo(movie: movieList[index],
                        reloadPageCallback: reloadPageCallback);
                  }
              );

            },
          );
        },
      ),
    );
  }
}
