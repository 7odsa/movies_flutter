import 'dart:convert';

import 'package:movies_flutter/_core/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:movies_flutter/_resources/helpers/shared_prefs.dart';
import 'package:movies_flutter/_resources/state_ui.dart';
import 'package:movies_flutter/common/movies_list/models/movie.dart';

class ProfileRemoteDs {
  Future<StateUi<bool, String>> addMovieToFavorite({
    required String movieId,
    required String name,
    required double rating,
    required String imageUrl,
    required String year,
  }) async {
    try {
      final url = Uri.https(baseUrl, "favorites/add");
      final token = SharedPrefs.getUserToken();
      final body = jsonEncode({
        "movieId": movieId,
        "name": name,
        "rating": rating,
        "imageURL": imageUrl,
        "year": year,
      });

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        return ErrorState('Something Went Wrong');
      }
      return SuccessState(true);
    } catch (e) {
      return ErrorState(e.toString());
    }
  }

  Future<StateUi<bool, String>> removeFavoriteMovie({
    required String movieId,
  }) async {
    try {
      final url = Uri.https(baseUrl, 'favorites/remove/$movieId');
      final token = SharedPrefs.getUserToken();

      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode < 200 || response.statusCode >= 300) {
        return ErrorState("ERror");
      }

      return SuccessState(false);
    } catch (e) {
      return ErrorState(e.toString());
    }
  }

  Future<StateUi<bool, String>> isMovieFavorite({
    required String movieId,
  }) async {
    try {
      final url = Uri.https(baseUrl, 'favorites/is-favorite/$movieId');
      final token = SharedPrefs.getUserToken();

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode < 200 && response.statusCode >= 300) {
        return ErrorState("Errorr");
      }
      final json = jsonDecode(response.body);
      return SuccessState(json['data']);
    } catch (e) {
      return ErrorState(e.toString());
    }
  }

  Future<StateUi<List<MovieDM>, String>> getAllFavorites() async {
    try {
      final url = Uri.https(baseUrl, 'favorites/all');
      final token = SharedPrefs.getUserToken();

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        return ErrorState("error");
      }
      final json = jsonDecode(response.body);
      final movies = MovieDM.listFromJson(json);
      return SuccessState(movies);
    } catch (e) {
      return ErrorState(e.toString());
    }
  }
}
