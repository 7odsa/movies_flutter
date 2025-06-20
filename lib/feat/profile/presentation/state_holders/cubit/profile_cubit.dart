import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_flutter/_resources/state_ui.dart';
import 'package:movies_flutter/common/movies_list/models/movie.dart';
import 'package:movies_flutter/feat/profile/data/repos/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<StateUi<List<MovieDM>, String>> {
  ProfileCubit(this.repo) : super(LoadingState());
  final ProfileRepo repo;

  void getFavoriteMovies() async {
    emit(LoadingState());
    final currState = await repo.getAllFavorites();
    emit(currState);
  }
}
