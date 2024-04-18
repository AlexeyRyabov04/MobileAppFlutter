import 'package:flutter/material.dart';
import 'package:mobileapp/services/UserService.dart';

import '../components/my_button.dart';
import '../components/my_image_slider.dart';
import '../models/movie_model.dart';

class MovieInfo extends StatefulWidget {
  final Movie movie;
  final VoidCallback reloadPageCallback;
  const MovieInfo({
    super.key,
    required this.movie,
    required this.reloadPageCallback
  });

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  bool isInFavorites = false;



  @override
  void initState() {
    super.initState();
    checkFavorites();
  }

  Future<void> checkFavorites() async{
    UserService userService = UserService();
    String userKey = await userService.getUserKey();
    bool check = await userService.checkMovieToFavourites(widget.movie.id, userKey);
    setState(() {
      isInFavorites = check;
    });
  }

  void toggleFavorites() {
    setState(() {
      isInFavorites = !isInFavorites;
    });
  }

  void onPressedFunction() async{
    UserService userService = UserService();
    String userKey = await userService.getUserKey();
    if (!isInFavorites) {
      userService.deleteFromFavourites(widget.movie.id, userKey);
    } else {
      userService.addToFavourites(widget.movie.id, userKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    String buttonText = isInFavorites ? 'Убрать из избранного' : 'Добавить в избранное';
    return WillPopScope(child:
      Dialog(
      child: SingleChildScrollView(child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.movie.title,
          style: const TextStyle(
            fontSize: 20
          ),),
          ImageSlider(movieId: widget.movie.id.toString()),
          Text('Режиссер: ${widget.movie.producer}', style: const TextStyle(
              fontSize: 20
          )),
          Text('Описание: ${widget.movie.description}', style: const TextStyle(
              fontSize: 20
          )),
          const SizedBox(height: 10),
          MyButton(onClick: () {
            onPressedFunction();
            toggleFavorites();
            },
            text: buttonText),
          const SizedBox(height: 10),
        ],
      ),
      ),
    ),
    onWillPop: () async {
        widget.reloadPageCallback();
        return true;
      },
    );

  }
}
