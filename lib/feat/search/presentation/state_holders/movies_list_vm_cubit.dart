import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_flutter/_resources/data_state.dart';
import 'package:movies_flutter/_resources/state_ui.dart';
import 'package:movies_flutter/common/movies_list/repos/movies_list_repo.dart';
import 'package:movies_flutter/common/movies_list/models/movie.dart';

class SearchVmCubit extends Cubit<StateUi<List<MovieDM>?, String?>> {
  SearchVmCubit({required this.repo}) : super(LoadingState());
  final MoviesListRepo repo;
  Future<void> getMoviesList({
    required String searchText,
    int? page,
    int? limit,
  }) async {
    emit(LoadingState());
    final result = await repo.getListOfMovies(
      searchTerm: searchText,
      limit: limit,
      page: page,
    );
    if (result is DataSuccess) {
      final moviesList = result.data;
      // (searchText.isEmpty)
      //     ? result.data
      //     : result.data
      //         ?.where(
      //           (element) =>
      //               element.title != null &&
      //               element.title!.contains(searchText),
      //         )
      //         .toList();
      emit(SuccessState(moviesList));
    } else {
      emit(ErrorState(result.errorMsg));
    }
  }
}
