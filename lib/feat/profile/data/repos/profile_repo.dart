import 'package:movies_flutter/_resources/state_ui.dart';
import 'package:movies_flutter/common/movies_list/models/movie.dart';
import 'package:movies_flutter/feat/profile/data/data_sources/profile_remote_ds.dart';

class ProfileRepo {
  final ProfileRemoteDs profileRemoteDs;

  ProfileRepo({required this.profileRemoteDs});

  Future<StateUi<bool, String>> addMovieToFavorite({
    required String movieId,
    required String name,
    required double rating,
    required String imageUrl,
    required String year,
  }) async {
    return profileRemoteDs.addMovieToFavorite(
      movieId: movieId,
      imageUrl: imageUrl,
      name: name,
      rating: rating,
      year: year,
    );
  }

  Future<StateUi<bool, String>> removeFavoriteMovie({
    required String movieId,
  }) async {
    return profileRemoteDs.removeFavoriteMovie(movieId: movieId);
  }

  Future<StateUi<bool, String>> isMovieFavorite({
    required String movieId,
  }) async {
    return profileRemoteDs.isMovieFavorite(movieId: movieId);
  }

  Future<StateUi<List<MovieDM>, String>> getAllFavorites() async {
    return profileRemoteDs.getAllFavorites();
  }
}
