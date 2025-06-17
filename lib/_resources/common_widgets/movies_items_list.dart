import 'package:flutter/material.dart';
import 'package:movies_flutter/_resources/common_widgets/movie_item.dart';
import 'package:movies_flutter/common/movies_list/models/movie.dart';

class MoviesItemsList extends StatelessWidget {
  const MoviesItemsList({
    super.key,
    required this.numOfTiles,
    required this.movies,
  });
  final int numOfTiles;
  final List<MovieDM> movies;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: numOfTiles,
        childAspectRatio: 9 / 13,
      ),
      itemBuilder: (context, index) {
        return Card(elevation: 16, child: MovieItem(movie: movies[index]));
      },
      itemCount: movies.length,
    );
  }
}
