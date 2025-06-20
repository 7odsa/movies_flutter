import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_flutter/_resources/state_ui.dart';
import 'package:movies_flutter/common/movies_list/models/movie.dart';
import 'package:movies_flutter/common/movies_list/repos/movies_list_repo.dart';

part 'available_vm_state.dart';

class AvailableVmCubit extends Cubit<StateUi<List<MovieDM>, String>> {
  AvailableVmCubit(this.repo) : super(LoadingState());
  final MoviesListRepo repo;

  void getLatestMovies() async {
    try {
      emit(LoadingState());
      final List<MovieDM> movies = (await repo.getLatestMovies()).data ?? [];
      emit(SuccessState(movies));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
