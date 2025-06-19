import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_flutter/common/movies_list/models/movie.dart';
import 'package:movies_flutter/common/movies_list/repos/movies_list_repo.dart';
import 'package:movies_flutter/feat/home/presentation/bloc/movie_event.dart';
import 'package:movies_flutter/feat/home/presentation/bloc/movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MoviesListRepo repo;

  MovieBloc(this.repo) : super(MoviesInitial()) {
    on<FetchMoviesByGenres>((event, emit) async {
      emit(MoviesLoading());

      final Map<String, List<MovieDM>> genreMovies = {};

      try {
        for (String genre in event.genres) {
          final List<MovieDM> movies =
              genre == "Latest"
                  ? (await repo.getLatestMovies()).data ?? []
                  : (await repo.getListOfMovies(genre: genre)).data ?? [];

          genreMovies[genre] = movies;
        }
        emit(MoviesLoadedByGenre(genreMovies));
      } catch (e) {
        emit(MoviesError('Failed to fetch movies: $e'));
      }
    });
  }
}
