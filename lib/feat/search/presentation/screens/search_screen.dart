import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_flutter/_core/constants/colors.dart';
import 'package:movies_flutter/_resources/common_widgets/movies_items_list.dart';
import 'package:movies_flutter/_resources/state_ui.dart';
import 'package:movies_flutter/common/movies_list/data_sources/remote_ds.dart';
import 'package:movies_flutter/common/movies_list/models/movie.dart';
import 'package:movies_flutter/common/movies_list/repos/movies_list_repo.dart';
import 'package:movies_flutter/feat/search/presentation/state_holders/movies_list_vm_cubit.dart';
import 'package:movies_flutter/generated/l10n.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final SearchVmCubit moviesListVM;

  @override
  void initState() {
    super.initState();
    moviesListVM = SearchVmCubit(
      browseRepo: MoviesListRepo(
        movieListRemoteDataSource: MoviesListRemoteDataSource(),
      ),
    );
    moviesListVM.getMoviesList(searchText: '');
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
      onChanged: (value) {
        moviesListVM.getMoviesList(searchText: value);
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
        if (state is SuccessState) {
          return MoviesItemsList(numOfTiles: 2, movies: state.data ?? []);
        } else if (state is ErrorState) {
          return Center(child: Text(state.error ?? ''));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
