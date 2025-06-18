import 'package:flutter/material.dart';
import 'package:movies_flutter/_core/constants/colors.dart';
import 'package:movies_flutter/common/movies_list/models/movie.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({super.key, required this.movie});
  final MovieDM movie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          // TODO
          child: Image.network(movie.mediumCoverImage ?? ""),
        ),
        movieRateIcon(),
      ],
    );
  }

  Widget movieRateIcon() {
    // TODO
    return Positioned(
      left: 6,
      top: 6,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: const Color.fromARGB(129, 0, 0, 0),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Text(movie.rating.toString()),
            Icon(Icons.star_rate_rounded, color: ColorsApp.yellow),
          ],
        ),
      ),
    );
  }
}
