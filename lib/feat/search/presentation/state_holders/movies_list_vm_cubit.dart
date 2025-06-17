import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_flutter/_resources/data_state.dart';
import 'package:movies_flutter/_resources/state_ui.dart';
import 'package:movies_flutter/common/movies_list/repos/movies_list_repo.dart';
import 'package:movies_flutter/common/movies_list/models/movie.dart';

class SearchVmCubit extends Cubit<StateUi<List<MovieDM>?, String?>> {
  SearchVmCubit({required this.browseRepo}) : super(LoadingState());
  final MoviesListRepo browseRepo;
  Future<void> getMoviesList({required String searchText}) async {
    emit(LoadingState());
    final result = await browseRepo.getListOfMovies(searchTerm: searchText);
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
