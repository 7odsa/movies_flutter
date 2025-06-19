import 'package:movies_flutter/common/movies_list/models/movie.dart';

abstract class MovieState {}

class MoviesInitial extends MovieState {}

class MoviesLoading extends MovieState {}

class MoviesLoadedByGenre extends MovieState {
  final Map<String, List<MovieDM>> moviesByGenre;
  MoviesLoadedByGenre(this.moviesByGenre);
}

class MoviesError extends MovieState {
  final String message;
  MoviesError(this.message);
}
