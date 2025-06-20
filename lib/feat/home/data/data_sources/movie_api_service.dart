import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieApiService {
  final String baseUrl = 'https://yts.mx/api/v2';

  Future<List<Movie>> fetchMoviesByGenre(String genre) async {
    final response = await http.get(
      Uri.parse('$baseUrl/list_movies.json?genre=$genre'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final moviesJson = jsonData['data']['movies'] as List<dynamic>;
      return moviesJson.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load $genre movies');
    }
  }
  Future<List<Movie>> fetchLatestMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/list_movies.json?sort_by=date_added'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List moviesJson = jsonData['data']['movies'];
      return moviesJson.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load latest movies');
    }
  }

}
