import 'package:get_it/get_it.dart';
import 'package:movies_flutter/common/movies_list/data_sources/remote_ds.dart';
import 'package:movies_flutter/common/movies_list/repos/movies_list_repo.dart';
import 'package:movies_flutter/feat/browse/presentation/state_holders/cubit/movies_list_vm_cubit.dart';
import 'package:movies_flutter/feat/search/presentation/state_holders/movies_list_vm_cubit.dart';

import 'package:movies_flutter/feat/home/data/data_sources/movie_api_service.dart';
import 'package:movies_flutter/feat/home/data/repos/movie_repo.dart';

final sl = GetIt.instance;

class Di {
  static void setupDependancyInjection() {
    sl.registerSingleton<MoviesListRemoteDataSource>(
      MoviesListRemoteDataSource(),
    );
    sl.registerSingleton<MoviesListRepo>(
      MoviesListRepo(movieListRemoteDataSource: sl()),
    );
    sl.registerSingleton<SearchVmCubit>(SearchVmCubit(repo: sl()));
    sl.registerSingleton<BrowseVmCubit>(BrowseVmCubit(repo: sl()));

    sl.registerLazySingleton<MovieApiService>(() => MovieApiService());
    sl.registerLazySingleton<MovieRepo>(() => MovieRepo(sl()));
  }
}
