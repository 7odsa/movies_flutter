import 'package:flutter/material.dart';
import 'package:movies_flutter/_core/constants/colors.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({super.key, required this.imageUrl, required this.rate});
  final String imageUrl;
  final String rate;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          // TODO
          child: Image.asset("assets/test_image.png"),
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
            Text("7.7"),
            Icon(Icons.star_rate_rounded, color: ColorsApp.yellow),
          ],
        ),
      ),
    );
  }
}
