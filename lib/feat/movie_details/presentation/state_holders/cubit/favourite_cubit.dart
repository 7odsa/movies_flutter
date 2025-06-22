import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_flutter/_resources/state_ui.dart';
import 'package:movies_flutter/feat/profile/data/repos/profile_repo.dart';

part 'profile_state.dart';

class FavouriteCubit extends Cubit<StateUi<bool, String>> {
  final ProfileRepo profileRepo;
  FavouriteCubit(this.profileRepo) : super(LoadingState());

  void isFavorite(String movieId) async {
    emit(LoadingState());

    final state = await profileRepo.isMovieFavorite(movieId: movieId);
    emit(state);
  }

  void addFavorite({
    required String movieId,
    required String imageUrl,
    required String name,
    required double rating,
    required String year,
  }) async {
    emit(LoadingState());

    final state = await profileRepo.addMovieToFavorite(
      movieId: movieId,
      imageUrl: imageUrl,
      name: name,
      rating: rating,
      year: year,
    );
    emit(state);
  }

  void removeFavorite({required String movieId}) async {
    emit(LoadingState());

    final state = await profileRepo.removeFavoriteMovie(movieId: movieId);
    emit(state);
  }
}
