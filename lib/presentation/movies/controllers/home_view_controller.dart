import 'package:demo_app/data/movies/repositories/movies_repository.dart';
import 'package:demo_app/domain/movies/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeViewController extends ChangeNotifier {
  // States
  List<Movie> _movies = [];

  // Getters
  List<Movie> get movies => _movies;

  // Dependencies
  final MoviesRepository _moviesRepository;

  HomeViewController(this._moviesRepository);

  Future<void> fetchMovies() async {
    try {
      _movies = await _moviesRepository.getPopularMovies();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}

final homeViewProvider = ChangeNotifierProvider((ref) {
  return HomeViewController(moviesRepository);
});
