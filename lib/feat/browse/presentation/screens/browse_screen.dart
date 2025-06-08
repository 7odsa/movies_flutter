import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movies_flutter/_resources/common_widgets/movies_items_list.dart';
import 'package:movies_flutter/feat/browse/presentation/widgets/category_item.dart';
import 'package:movies_flutter/generated/l10n.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen>
    with SingleTickerProviderStateMixin {
  // late final _tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    // _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Set<String> genresList = {
      S.of(context).action,
      S.of(context).adventure,
      S.of(context).animation,
      S.of(context).anime,
      S.of(context).comedy,
      S.of(context).crime,
      S.of(context).documentary,
      S.of(context).drama,
      S.of(context).family,
      S.of(context).fantasy,
      S.of(context).sport,
      S.of(context).horror,
      S.of(context).music,
      S.of(context).thriller,
      S.of(context).musical,
      S.of(context).mystery,
      S.of(context).romance,
      S.of(context).sci_fi,
      S.of(context).western,
    };
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
