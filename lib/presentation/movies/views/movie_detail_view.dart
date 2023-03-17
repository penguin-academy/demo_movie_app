import 'package:demo_app/domain/movies/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieDetailView extends StatelessWidget {
  final Movie movie;
  const MovieDetailView({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
    );
  }
}
