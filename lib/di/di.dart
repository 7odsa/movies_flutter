import 'package:get_it/get_it.dart';
import 'package:movies_flutter/common/movies_list/data_sources/remote_ds.dart';
import 'package:movies_flutter/common/movies_list/repos/movies_list_repo.dart';
import 'package:movies_flutter/feat/auth/data/data_sources/auth_remote_ds.dart';
import 'package:movies_flutter/feat/auth/data/repos/auth_repo.dart';
import 'package:movies_flutter/feat/browse/presentation/state_holders/cubit/movies_list_vm_cubit.dart';
import 'package:movies_flutter/feat/home/presentation/bloc/movie_bloc.dart';

import 'package:movies_flutter/feat/home/data/data_sources/movie_api_service.dart';
import 'package:movies_flutter/feat/home/data/repos/movie_repo.dart';
import 'package:movies_flutter/feat/profile/data/data_sources/profile_remote_ds.dart';
import 'package:movies_flutter/feat/profile/data/repos/profile_repo.dart';
import 'package:movies_flutter/feat/search/presentation/state_holders/movies_list_vm_cubit.dart';

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
    sl.registerLazySingleton<MovieBloc>(() => MovieBloc(sl()));

    sl.registerLazySingleton<AuthRemoteDS>(() => AuthRemoteDS());
    sl.registerLazySingleton<AuthRepo>(() => AuthRepo(authRemoteDS: sl()));

    sl.registerLazySingleton<ProfileRemoteDs>(() => ProfileRemoteDs());
    sl.registerLazySingleton<ProfileRepo>(
      () => ProfileRepo(profileRemoteDs: sl()),
    );
  }
}
