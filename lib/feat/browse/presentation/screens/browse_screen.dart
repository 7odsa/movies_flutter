import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_flutter/_core/constants/colors.dart';
import 'package:movies_flutter/_core/constants/genre_list.dart';
import 'package:movies_flutter/_resources/common_widgets/movies_items_list.dart';
import 'package:movies_flutter/_resources/state_ui.dart';
import 'package:movies_flutter/common/movies_list/repos/movies_list_repo.dart';
import 'package:movies_flutter/common/movies_list/data_sources/remote_ds.dart';
import 'package:movies_flutter/common/movies_list/models/movie.dart';
import 'package:movies_flutter/feat/browse/presentation/state_holders/cubit/movies_list_vm_cubit.dart';
import 'package:movies_flutter/feat/browse/presentation/widgets/category_item.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key, this.genreName});
  final String? genreName;
  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen>
    with SingleTickerProviderStateMixin {
  // late final _tabController;
  late String selectedGenre = "";
  late Set<String> _genresList;
  late final BrowseVmCubit browseVM;
  int page = 1;
  final int limit = 20;
  List<MovieDM> movies = [];

  @override
  void initState() {
    super.initState();
    _genresList = Genres.allKeys;
    selectedGenre = widget.genreName ?? _genresList.elementAt(0);
    browseVM = BrowseVmCubit(
      browseRepo: MoviesListRepo(
        movieListRemoteDataSource: MoviesListRemoteDataSource(),
      ),
    );
    browseVM.getMoviesList(page: page, genre: selectedGenre, limit: limit);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildGenreBar(),
        SizedBox(height: 8),
        // giving list of movies to MoviesItemsList
        buildMovieList(),
      ],
    );
  }

  buildMovieList() {
    return BlocBuilder<BrowseVmCubit, StateUi<List<MovieDM>?, String?>>(
      bloc: browseVM,
      builder: (context, state) {
        print(state.data?[0].genres);

        if (isVmStateIsSuccessStateOrOnPagination(state)) {
          if (page == 1) {
            movies = state.data ?? [];
          } else {
            movies.addAll(state.data ?? []);
          }
          return Expanded(
            child: RefreshIndicator(
              color: ColorsApp.yellow,
              onRefresh: () async {
                page = 1;
                browseVM.getMoviesList(
                  page: page,
                  genre: selectedGenre,
                  limit: limit,
                );
              },
              child: MoviesItemsList(
                limit: limit,
                movies: movies,
                numOfTiles: 2,
                onFetchingData: () {
                  browseVM.getMoviesList(
                    page: ++page,
                    genre: selectedGenre,
                    limit: limit,
                  );
                },
              ),
            ),
          );
        } else if (state is ErrorState) {
          return Center(child: Text(state.error!));
        } else {
          return Column(children: [Center(child: CircularProgressIndicator())]);
        }
      },
    );
  }

  bool isVmStateIsSuccessStateOrOnPagination(
    StateUi<List<MovieDM>?, String?> state,
  ) => state is SuccessState || (page > 1 && state is LoadingState);

  Widget buildGenreBar() {
    double height = MediaQuery.sizeOf(context).height;
    return SizedBox(
      height: 0.05 * height,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(width: 16);
        },
        itemBuilder: (context, index) {
          return Center(
            child: CategoryItem(
              onItemTapped: () {
                setState(() {
                  selectedGenre = _genresList.elementAt(index);
                  page = 1;
                  browseVM.getMoviesList(
                    page: page,
                    genre: selectedGenre,
                    limit: limit,
                  );
                });
              },
              genreName: _genresList.elementAt(index),
              isSelectedItem:
                  _genresList.elementAt(index).toLowerCase() ==
                  selectedGenre.toLowerCase(),
            ),
          );
        },
        itemCount: _genresList.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
