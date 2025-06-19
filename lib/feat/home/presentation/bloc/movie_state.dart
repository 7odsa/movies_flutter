import '../../data/models/movie_model.dart';

abstract class MovieState {}

class MoviesInitial extends MovieState {}

class MoviesLoading extends MovieState {}

class MoviesLoadedByGenre extends MovieState {
  final Map<String, List<Movie>> moviesByGenre;
  MoviesLoadedByGenre(this.moviesByGenre);
}

class MoviesError extends MovieState {
  final String message;
  MoviesError(this.message);
}
