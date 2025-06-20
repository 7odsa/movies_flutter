import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_flutter/_resources/data_state.dart';
import 'package:movies_flutter/_resources/state_ui.dart';
import 'package:movies_flutter/common/movies_list/repos/movies_list_repo.dart';
import 'package:movies_flutter/common/movies_list/models/movie.dart';

part 'movies_list_vm_state.dart';

class BrowseVmCubit extends Cubit<StateUi<List<MovieDM>?, String?>> {
  BrowseVmCubit({required this.repo}) : super(LoadingState());
  final MoviesListRepo repo;
  Future<void> getMoviesList({
    required int page,
    String? genre,
    required int limit,
  }) async {
    emit(LoadingState());
    final result = await repo.getListOfMovies(
      page: page,
      genre: genre,
      limit: limit,
    );
    if (result is DataSuccess) {
      emit(SuccessState(result.data));
    } else {
      emit(ErrorState(result.errorMsg));
    }
  }
}
