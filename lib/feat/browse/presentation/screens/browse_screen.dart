import 'package:flutter/material.dart';
import 'package:movies_flutter/_core/constants/genre_list.dart';
import 'package:movies_flutter/_resources/common_widgets/movies_items_list.dart';
import 'package:movies_flutter/feat/browse/presentation/widgets/category_item.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key, this.genreName});
  final String? genreName;
  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen>
    with SingleTickerProviderStateMixin {
  // late final _tabController;
  late String selectedGenre = "";
  late Set<String> _genresList;

  @override
  void initState() {
    super.initState();
    _genresList = Genres.allKeys;
    selectedGenre = widget.genreName ?? _genresList.elementAt(0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(width: 16);
            },
            itemBuilder: (context, index) {
              return Center(
                child: CategoryItem(
                  onItemTapped: () {
                    setState(() {
                      selectedGenre = _genresList.elementAt(index);
                    });
                  },
                  genreName: _genresList.elementAt(index),
                  isSelectedItem:
                      _genresList.elementAt(index).toLowerCase() ==
                      selectedGenre.toLowerCase(),
                ),
              );
            },
            itemCount: _genresList.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(height: 4),
        // TODO: giving list of movies to MoviesItemsList
        Expanded(child: MoviesItemsList(numOfTiles: 2)),
      ],
    );
  }
}
