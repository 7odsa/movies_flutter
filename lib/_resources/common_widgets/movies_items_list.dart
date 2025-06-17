import 'package:flutter/material.dart';
import 'package:movies_flutter/_resources/common_widgets/movie_item.dart';
import 'package:movies_flutter/common/movies_list/models/movie.dart';

class MoviesItemsList extends StatefulWidget {
  const MoviesItemsList({
    super.key,
    required this.numOfTiles,
    required this.movies,
    this.onFetchingData,
    required this.limit,
  });
  final int limit;
  final int numOfTiles;
  final List<MovieDM> movies;
  final void Function()? onFetchingData;
  @override
  State<MoviesItemsList> createState() => _MoviesItemsListState();
}

class _MoviesItemsListState extends State<MoviesItemsList> {
  final ScrollController scrollController = ScrollController();
  late List<MovieDM> moviesList;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    moviesList = widget.movies;
    scrollController.addListener(() {
      if (widget.onFetchingData != null &&
          scrollController.position.maxScrollExtent ==
              scrollController.position.pixels) {
        widget.onFetchingData!();
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: widget.numOfTiles,
        childAspectRatio: 9 / 13,
      ),
      itemBuilder: (context, index) {
        if (index < moviesList.length) {
          return Card(
            elevation: 16,
            child: MovieItem(movie: moviesList[index]),
          );
        } else {
          return (moviesList.length % widget.limit == 0)
              ? Column(
                children: [CircularProgressIndicator(), Text('Loading More')],
              )
              : Center(child: Text('No More'));
        }
      },
      itemCount: moviesList.length + 1,
    );
  }
}
