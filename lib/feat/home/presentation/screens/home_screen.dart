import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_flutter/_core/constants/colors.dart';
import 'package:movies_flutter/feat/home/presentation/widgets/available_movies_list.dart';
import 'package:movies_flutter/feat/home/presentation/widgets/watch_list_movies.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';
import '../bloc/movie_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> genres = ["Latest", "Action", "Comedy", "Animation", "Horror"];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(FetchMoviesByGenres(genres));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.black,
      body: SafeArea(
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MoviesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MoviesLoadedByGenre) {
              final genreMovies = state.moviesByGenre;

              return SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  children: genres.map((genre) {
                    final movies = genreMovies[genre] ?? [];

                    if (movies.isEmpty) return const SizedBox();

                    if (genre == "Latest") {
                      return AvailableMoviesList(
                        movies: movies,
                        currentIndex: currentIndex,
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      );
                    }

                    return WatchListMovies(
                      movies: movies,
                      movieType: genre,
                    );
                  }).toList(),
                ),
              );
            } else if (state is MoviesError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
