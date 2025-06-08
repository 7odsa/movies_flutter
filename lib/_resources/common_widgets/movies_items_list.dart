import 'package:flutter/material.dart';
import 'package:movies_flutter/_resources/common_widgets/movie_item.dart';

class MoviesItemsList extends StatelessWidget {
  const MoviesItemsList({super.key, required this.numOfTiles});
  final int numOfTiles;
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
        return Card(
          elevation: 16,
          child: MovieItem(imageUrl: "imageUrl", rate: "1.92"),
        );
      },
      itemCount: 23,
    );
  }
}
