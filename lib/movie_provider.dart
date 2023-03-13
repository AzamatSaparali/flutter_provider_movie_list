import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_provider/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final List<Movie> initialData = List.generate(
  50,
      (index) =>
      Movie(
          title: "Movie $index",
          duration: "${Random().nextInt(100) + 60} minutes"),
);

class MovieProvider with ChangeNotifier {
  final List<Movie> _movies = initialData;
  SharedPreferences? sharedPreferences;
  final Future<SharedPreferences> _myStorage = SharedPreferences.getInstance();

  List<Movie> get movies => _movies;

  final List<Movie> _myList = [];

  List<Movie> get myList {
    return _myList;
  }

  void initMovieData() async {
    loadDataFromLocalStorage();
    notifyListeners();
  }

  void storeMovie() async {
    final SharedPreferences myStorage = await _myStorage;
    List<String>? encodedMovieList =
    _myList.map((e) => json.encode(e.toJson())).toList();
    myStorage.setStringList('myData', encodedMovieList);
  }

  void loadDataFromLocalStorage() async {
    final SharedPreferences myStorage = await _myStorage;
    List<String>? spList = myStorage.getStringList('myData');
    if (spList != null) {
      //_myList.clear();
      spList.map((e) => _myList.add((json.decode(e))));

      print(spList);
    }
  }

  void addToList(Movie movie) {
    _myList.add(movie);
    storeMovie();
    loadDataFromLocalStorage();
    notifyListeners();
  }

  void removeFromList(Movie movie) {
    _myList.remove(movie);
    storeMovie();
    loadDataFromLocalStorage();
    notifyListeners();
  }
}
