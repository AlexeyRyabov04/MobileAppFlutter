import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/movie_model.dart';

class MovieService{
  final DatabaseReference ref = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: "https://mobileapp-38ff9-default-rtdb.europe-west1.firebasedatabase.app",
  ).ref('movies');

  final List<int> favorites;
  MovieService(this.favorites);

  Future<List<Movie>> getMovies() async {
    List<Movie> items = [];
    try {
      DataSnapshot snapshot = await ref.get();
      Map<dynamic, dynamic> values = Map<dynamic, dynamic>.from(snapshot.value as dynamic);
      values.forEach((key, value) {
        Movie movie = Movie(
            id: value['id'],//value['id'],
            title: value['title'],
            description: value['description'],
            producer: value['producer']
        );
        bool isInList = false;
        for (var element in items) {
          if(element.id == movie.id){
            isInList = true;
            break;
          }
        }
        if (!isInList && (favorites.isEmpty || favorites.contains(movie.id))){
          items.add(movie);
        }
      });
    } catch (e) {
      print(e);
    }
    items.sort((a, b) => a.id.compareTo(b.id));
    return items;
  }

  Future<List<String>> getImages(String id) async {
    List<String> fileUrls = [];
    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance.ref().child("images").child(id);
    final List<firebase_storage.Reference> allFiles =
    await ref.listAll().then((value) => value.items);
    for (firebase_storage.Reference file in allFiles) {
      final String downloadUrl = await file.getDownloadURL();
      fileUrls.add(downloadUrl);
    }
    return fileUrls;
  }
}