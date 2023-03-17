import 'package:demo_app/domain/movies/models/movie_model.dart';

abstract class MoviesRepositoryAbstract {
  Future<List<Movie>> getPopularMovies();
}
