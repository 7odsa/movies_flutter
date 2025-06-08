import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movies_flutter/_resources/common_widgets/movies_items_list.dart';

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
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Text(
                    "data",
                    style: TextStyle(
                      color:
                          (selectedIndex == index)
                              ? Colors.redAccent
                              : Colors.white,
                    ),
                  ),
                ),
              );
            },
            itemCount: 50,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(height: 4),
        Expanded(child: MoviesItemsList(numOfTiles: 2)),
      ],
    );
  }
}
