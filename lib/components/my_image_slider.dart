import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../services/MovieService.dart';

class ImageSlider extends StatefulWidget {

  final String movieId;
  ImageSlider({required this.movieId});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  void loadImages() async {
    MovieService movieService = MovieService([]);
    List<String> urls = await movieService.getImages(widget.movieId);
    setState(() {
      imageUrls = urls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
      ),
      items: imageUrls.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}