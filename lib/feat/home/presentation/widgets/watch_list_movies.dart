import 'package:flutter/material.dart';
import 'package:movies_flutter/_core/constants/app_style.dart';
import 'package:movies_flutter/_core/constants/colors.dart';
import 'package:movies_flutter/feat/home/data/models/movie_model.dart';
import 'package:movies_flutter/feat/home/presentation/widgets/movie_card.dart';

class WatchListMovies extends StatelessWidget {
  final List<Movie> movies;
  final String movieType;

  const WatchListMovies({
    super.key,
    required this.movies,
    required this.movieType,
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
                child: Text(movieType, style: AppStyle.textTheme.displaySmall),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text("See More ", style: AppStyle.textTheme.titleSmall),
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
                      //TODO
                    },
                    rating: movies[index].rating.toString(),
                    imagePath: movies[index].image,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
