import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/MovieDetailsModel.dart' show MovieDetailsModel;
import '../models/MovieModel_similar.dart' show MovieModelSimilar, MovieModel_similar;

class MoviesRepository {
  static Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    final response = await http.get(
      Uri.parse(
        'https://yts.mx/api/v2/movie_details.json?movie_id=$movieId&with_images=true&with_cast=true',
      ),
    );

    if (response.statusCode == 200) {
      return MovieDetailsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  static Future<List<MovieModelSimilar>> getSimilarMovies(int movieId) async {
    final response = await http.get(
      Uri.parse(
        'https://yts.mx/api/v2/movie_suggestions.json?movie_id=$movieId',
      ),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List movies = jsonData['data']['movies'] ?? [];
      return movies
          .map((json) => MovieModelSimilar.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load similar movies');
    }
  }
}
