import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_flutter/feat/home/data/models/movie_model.dart';
import 'package:movies_flutter/feat/home/data/repos/movie_repo.dart';
import 'package:movies_flutter/feat/home/presentation/bloc/movie_event.dart';
import 'package:movies_flutter/feat/home/presentation/bloc/movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepo repo;

  MovieBloc(this.repo) : super(MoviesInitial()) {
    on<FetchMoviesByGenres>((event, emit) async {
      emit(MoviesLoading());

      final Map<String, List<Movie>> genreMovies = {};

      try {
        for (String genre in event.genres) {
          final movies = genre == "Latest"
              ? await repo.getLatestMovies()
              : await repo.getMoviesByGenre(genre);

          genreMovies[genre] = movies;
        }
        emit(MoviesLoadedByGenre(genreMovies));
      } catch (e) {
        emit(MoviesError('Failed to fetch movies: $e'));
      }
    });
  }
}
