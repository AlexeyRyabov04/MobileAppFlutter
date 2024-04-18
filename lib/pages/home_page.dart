import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobileapp/services/MovieService.dart';

import '../models/movie_model.dart';
import 'movie_info_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> movieList = [];

  void reloadPageCallback() {
  }

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    MovieService movieService = MovieService([]);
    List<Movie> items = await movieService.getMovies();
      setState(() {
        movieList = items;
      });
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
