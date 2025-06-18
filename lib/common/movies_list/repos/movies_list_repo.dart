import 'package:movies_flutter/_resources/data_state.dart';
import 'package:movies_flutter/common/movies_list/data_sources/remote_ds.dart';
import 'package:movies_flutter/common/movies_list/models/movie.dart';

class MoviesListRepo {
  final MoviesListRemoteDataSource movieListRemoteDataSource;

  MoviesListRepo({required this.movieListRemoteDataSource});

  Future<DataState<List<MovieDM>?>> getListOfMovies({
    int? page,
    String? genre,
    String? searchTerm,
    int? limit,
  }) async {
    // TODO check connectivity

    return movieListRemoteDataSource.getListOfMovies(
      page: page,
      genre: genre,
      searchTerm: searchTerm,
      limit: limit,
    );
  }
}
