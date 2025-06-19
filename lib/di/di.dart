import 'package:get_it/get_it.dart';
import 'package:movies_flutter/feat/home/data/data_sources/movie_api_service.dart';
import 'package:movies_flutter/feat/home/data/repos/movie_repo.dart';

final sl = GetIt.instance;

class Di {
  static void setupDependancyInjection() {
    // sl.registerFactory<int>();
    sl.registerLazySingleton<MovieApiService>(() => MovieApiService());
    sl.registerLazySingleton<MovieRepo>(() => MovieRepo(sl()));

  }
}
