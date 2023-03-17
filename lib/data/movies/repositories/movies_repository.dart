import 'dart:developer';

import 'package:demo_app/data/services/http_client.dart';
import 'package:demo_app/domain/movies/models/movie_model.dart';
import 'package:demo_app/domain/movies/repositories/movies_repositories.dart';

class MoviesRepository implements MoviesRepositoryAbstract {
  final HttpClient _httpClient;

  MoviesRepository(this._httpClient);

  @override
  Future<List<Movie>> getPopularMovies() async {
    final response = await _httpClient.get('');

    final movies = (response.data['results'] as List)
        .map((e) => Movie.fromJson(e))
        .toList();

    log(movies.toString());

    return movies;
  }
}

final moviesRepository = MoviesRepository(httpClient);
