import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserService{
  final DatabaseReference ref = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: "https://mobileapp-38ff9-default-rtdb.europe-west1.firebasedatabase.app",
  ).ref('users');

  Future<String> getUserKey() async{
    String userKey = "";
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null){
      DataSnapshot snapshot = await ref.get();
      Map<dynamic, dynamic> values = Map<dynamic, dynamic>.from(snapshot.value as dynamic);
      values.forEach((key, value) {
        if (value['email'].toString() == user.email) {
          userKey = key;
          return;
        }
      });
    }
    return userKey;
  }
  Future<List<int>> getListOfFavourites(String userKey) async{
    List<int> favorites = [];
    DataSnapshot snapshot = await ref.child(userKey).child('favourites').get();
    if (snapshot.value == null){
      return [];
    }
    List<dynamic> tmp = snapshot.value as List<dynamic>;
    favorites = tmp.cast<int>().toList();
    return favorites;
  }

  Future<void> addToFavourites(int id, String userKey) async{
    List<int> favorites = await getListOfFavourites(userKey);
    favorites.add(id);
    await ref.child(userKey).child('favourites').set(favorites);
  }

  Future<void> deleteFromFavourites(int id, String userKey) async{
    List<int> favorites = await getListOfFavourites(userKey);
    favorites.remove(id);
    await ref.child(userKey).child('favourites').set(favorites);
  }

  Future<bool> checkMovieToFavourites(int id, String userKey) async{
    List<int> favorites = await getListOfFavourites(userKey);
    if (favorites.contains(id)){
      return true;
    }
    return false;
  }

  Future<void> saveChanges(String nick, String name, String surname, String phone) async{
      String userKey = await getUserKey();
      await ref.child(userKey).update({
        "name": name,
        "nick": nick,
        "surname": surname,
        "phone": phone
      }
      );
  }

  Future<void> createUser(String email) async{
    await ref.push().set({
      "name": "",
      "nick": "",
      "surname": "",
      "phone": "",
      "email": email,
    }
    );
  }

  Future<Person> getFields() async{
    String userKey = await getUserKey();
    DataSnapshot snapshot = await ref.child(userKey).get();
    Map<dynamic, dynamic> values = Map<dynamic, dynamic>.from(snapshot.value as dynamic);
    Person person = Person(email: values["email"],
        favorites: [],
        name: values["name"],
        nick: values["nick"],
        surname: values["surname"],
        phone: values["phone"]);
    return person;
  }

}