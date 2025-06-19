import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_flutter/_core/constants/colors.dart';
import 'package:movies_flutter/_resources/common_widgets/movies_items_list.dart';
import 'package:movies_flutter/_resources/state_ui.dart';
import 'package:movies_flutter/common/movies_list/models/movie.dart';
import 'package:movies_flutter/di/di.dart';
import 'package:movies_flutter/feat/search/presentation/state_holders/movies_list_vm_cubit.dart';
import 'package:movies_flutter/generated/l10n.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int page = 1;
  final int limit = 20;
  List<MovieDM> movies = [];
  final controller = TextEditingController();
  final SearchVmCubit moviesListVM = sl();

  @override
  void initState() {
    super.initState();

    moviesListVM.getMoviesList(searchText: '', limit: limit, page: page);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildSearchBar(context),
        SizedBox(height: 8),
        Expanded(child: buildMoviesList()),
      ],
    );
  }

  Widget buildSearchBar(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        page = 1;
        moviesListVM.getMoviesList(searchText: value, limit: limit, page: page);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorsApp.darkGreen,
        hintText: S.of(context).search,
        // TODO
        prefixIcon: Image.asset("assets/search_icon.png"),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: EdgeInsets.only(top: 4, left: 4, right: 4),
      ),
    );
  }

  Widget buildMoviesList() {
    return BlocBuilder<SearchVmCubit, StateUi<List<MovieDM>?, String?>>(
      bloc: moviesListVM,
      builder: (context, state) {
        if (isVmStateIsSuccessStateOrOnPagination(state)) {
          if (page == 1) {
            movies = state.data ?? [];
          } else {
            movies.addAll(state.data ?? []);
          }
          return RefreshIndicator(
            color: ColorsApp.yellow,
            onRefresh: () async {
              page = 1;
              moviesListVM.getMoviesList(
                page: page,
                searchText: controller.text,
                limit: limit,
              );
            },
            child: MoviesItemsList(
              numOfTiles: 2,
              movies: movies,
              limit: limit,
              onFetchingData: () {
                moviesListVM.getMoviesList(
                  page: ++page,
                  searchText: controller.text,
                  limit: limit,
                );
              },
            ),
          );
        } else if (state is ErrorState) {
          return Center(child: Text(state.error ?? ''));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  bool isVmStateIsSuccessStateOrOnPagination(
    StateUi<List<MovieDM>?, String?> state,
  ) => state is SuccessState || (page > 1 && state is LoadingState);
}
