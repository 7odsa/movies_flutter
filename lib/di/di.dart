import 'package:get_it/get_it.dart';
import 'package:movies_flutter/common/movies_list/data_sources/remote_ds.dart';
import 'package:movies_flutter/common/movies_list/repos/movies_list_repo.dart';
import 'package:movies_flutter/feat/browse/presentation/state_holders/cubit/movies_list_vm_cubit.dart';
import 'package:movies_flutter/feat/search/presentation/state_holders/movies_list_vm_cubit.dart';

final sl = GetIt.instance;

class Di {
  static void setupDependancyInjection() {
    sl.registerLazySingleton<MoviesListRemoteDataSource>(
      () => MoviesListRemoteDataSource(),
    );
    sl.registerLazySingleton<MoviesListRepo>(
      () => MoviesListRepo(movieListRemoteDataSource: sl()),
    );
    sl.registerLazySingleton<SearchVmCubit>(() => SearchVmCubit(repo: sl()));
    sl.registerLazySingleton<BrowseVmCubit>(() => BrowseVmCubit(repo: sl()));
  }
}
