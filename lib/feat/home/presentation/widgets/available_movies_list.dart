import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_flutter/_core/constants/app_style.dart';
import 'package:movies_flutter/_core/constants/colors.dart';
import 'package:movies_flutter/common/movies_list/models/movie.dart';
import 'package:movies_flutter/feat/movie_details/presentation/screens/MovieDetails_UI.dart';
import 'package:movies_flutter/feat/profile/presentation/state_holders/cubit/profile_cubit.dart';
import '../../data/models/movie_model.dart';
import 'movie_card.dart';

class AvailableMoviesList extends StatelessWidget {
  final List<MovieDM> movies;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;

  const AvailableMoviesList({
    super.key,
    required this.movies,
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              movies[currentIndex].mediumCoverImage ?? '',
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => Container(
                    color: ColorsApp.lightBlack,
                    child: Icon(
                      Icons.broken_image,
                      size: 60,
                      color: ColorsApp.red,
                    ),
                  ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [ColorsApp.transparent, ColorsApp.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 12),
              Text('Available Now', style: AppStyle.textTheme.headlineLarge),
              SizedBox(height: 20),
              Expanded(
                child: CarouselSlider.builder(
                  itemCount: movies.length,
                  itemBuilder:
                      (context, index, realIndex) => MovieCard(
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
                  options: CarouselOptions(
                    height: 300,
                    viewportFraction: 0.5,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.25,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) => onPageChanged(index),
                  ),
                ),
              ),
              Text("Watch Now", style: AppStyle.textTheme.headlineLarge),
            ],
          ),
        ],
      ),
    );
  }
}
