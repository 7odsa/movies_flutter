import '../data_sources/movie_api_service.dart';
import '../models/movie_model.dart';

class MovieRepo {
  final MovieApiService apiService;

  MovieRepo(this.apiService);

  Future<List<Movie>> getMoviesByGenre(String genre) {
    return apiService.fetchMoviesByGenre(genre);
  }

  Future<List<Movie>> getLatestMovies() {
    return apiService.fetchLatestMovies();
  }
}
