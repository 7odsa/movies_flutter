abstract class MovieEvent {}

class FetchMoviesByGenres extends MovieEvent {
  final List<String> genres;
  FetchMoviesByGenres(this.genres);
}
