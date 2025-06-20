import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_flutter/_core/constants/app_style.dart';
import 'package:movies_flutter/_core/constants/colors.dart';
import 'package:movies_flutter/_core/constants/genre_list.dart';
import 'package:movies_flutter/_resources/common_state_holders/nav_screen_sh/cubit/nav_screen_cubit.dart';
import 'package:movies_flutter/common/movies_list/models/movie.dart';
import 'package:movies_flutter/feat/browse/presentation/screens/browse_screen.dart';
import 'package:movies_flutter/feat/home/presentation/widgets/movie_card.dart';
import 'package:movies_flutter/feat/movie_details/presentation/screens/MovieDetails_UI.dart';
import 'package:movies_flutter/generated/l10n.dart';

class WatchListMovies extends StatelessWidget {
  final List<MovieDM> movies;
  final String genreName;

  const WatchListMovies({
    super.key,
    required this.movies,
    required this.genreName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: double.infinity,
      child: Column(
        spacing: 8,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  Genres.getLocalizedGenreName(context, genreName),
                  style: AppStyle.textTheme.displayMedium,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    BlocBuilder<NavScreenCubit, Widget>(
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            context.read<NavScreenCubit>().changeScreen(
                              BrowseScreen(genreName: genreName),
                            );
                          },
                          child: Text(
                            S.of(context).see_more,
                            style: AppStyle.textTheme.titleSmall,
                          ),
                        );
                      },
                    ),
                    Icon(
                      Icons.arrow_forward_outlined,
                      size: 14,
                      color: ColorsApp.yellow,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder:
                  (context, index) => MovieCard(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => MovieDetailsScreen(
                                movieId: movies[index].id ?? 0,
                              ),
                        ),
                      );
                    },
                    rating: movies[index].rating.toString(),
                    imagePath: movies[index].mediumCoverImage ?? '',
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
