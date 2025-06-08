import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movies_flutter/_resources/common_widgets/movies_items_list.dart';
import 'package:movies_flutter/feat/browse/presentation/widgets/category_item.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen>
    with SingleTickerProviderStateMixin {
  // late final _tabController;
  int selectedIndex = 0;
  final Set<String> genresList = {
    'Action',
    'Adventure',
    'Animation',
    'Anime',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
    'Sport',
    'Horror',
    'Music',
    'Thriller',
    'Musical',
    'Mystery',
    'Romance',
    'Sci-Fi',
    'Western',
  };

  @override
  void initState() {
    // _tabController = TabController(length: 3, vsync: this);
    super.initState();
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
                      selectedIndex = index;
                    });
                  },
                  genreName: genresList.elementAt(index),
                  isSelectedItem: selectedIndex == index,
                ),
              );
            },
            itemCount: genresList.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(height: 4),
        // TODO
        Expanded(child: MoviesItemsList(numOfTiles: 2)),
      ],
    );
  }
}
