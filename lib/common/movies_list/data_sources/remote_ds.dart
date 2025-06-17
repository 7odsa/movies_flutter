import 'dart:convert';

import 'package:movies_flutter/_resources/data_state.dart';
import 'package:movies_flutter/common/movies_list/models/movie.dart';
import 'package:http/http.dart' as http;

class MoviesListRemoteDataSource {
  Future<DataState<List<MovieDM>?>> getListOfMovies({
    int? page,
    String? genre,
    String? searchTerm,
    int? limit,
  }) async {
    try {
      var url = Uri.https("yts.mx", 'api/v2/list_movies.json', {
        if (genre != null) "genre": genre,
        if (page != null) 'page': page.toString(),
        if (searchTerm != null) 'query_term': searchTerm.toLowerCase(),
        if (limit != null) 'limit': limit.toString(),
        'sort_by': 'like_count',
      });
      var response = await http.get(url);
      final json = jsonDecode(response.body);
      if (response.statusCode < 200 && response.statusCode >= 300) {
        return DataFailed(response.body);
      }
      // print(response.body);
      ResponseMovie responseMovie = ResponseMovie.fromJson(json);
      // TODO
      return DataSuccess(responseMovie.data!.movies);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
