import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/MovieDetailsModel.dart';
import '../../data/models/MovieModel_similar.dart';
import '../../data/data_sources/Repository.dart';


// ---------------------------
// EVENTS
// ---------------------------
abstract class MovieDetailsEvent {}

class FetchMovieDetails extends MovieDetailsEvent {
  final int movieId;

  FetchMovieDetails(this.movieId);
}


// ---------------------------
// STATES
// ---------------------------
abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final MovieDetailsModel movieDetails;
  final List<MovieModelSimilar> similarMovies;

  MovieDetailsLoaded(this.movieDetails, this.similarMovies);
}

class MovieDetailsError extends MovieDetailsState {
  final String message;

  MovieDetailsError(this.message);
}


// ---------------------------
// BLOC
// ---------------------------
class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  MovieDetailsBloc() : super(MovieDetailsInitial()) {
    on<FetchMovieDetails>(_onFetchMovieDetails);
  }

  Future<void> _onFetchMovieDetails(
      FetchMovieDetails event,
      Emitter<MovieDetailsState> emit,
      ) async {
    emit(MovieDetailsLoading());
    try {
      final movieDetails = await MoviesRepository.getMovieDetails(event.movieId);
      final similarMovies = await MoviesRepository.getSimilarMovies(event.movieId);
      emit(MovieDetailsLoaded(movieDetails, similarMovies));
    } catch (e) {
      emit(MovieDetailsError('فشل في تحميل تفاصيل الفيلم. حاول مرة أخرى.'));
    }
  }
}
