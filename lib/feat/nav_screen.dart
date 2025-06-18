import 'package:flutter/material.dart';
import 'package:movies_flutter/_core/constants/colors.dart';
import 'package:movies_flutter/_core/constants/nav_icons.dart';
import 'package:movies_flutter/feat/browse/presentation/screens/browse_screen.dart';
import 'package:movies_flutter/feat/search/presentation/screens/search_screen.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  // double screenWidth = MediaQuery.sizeOf(context).width;

  // TODO: for now and change it later to home screen
  late Widget contentScreen;

  // TODO: adding screens when finished
  Map<String, Widget> iconsScreenMap = {
    Navicons.home: SearchScreen(),
    Navicons.search: SearchScreen(),
    Navicons.browse: BrowseScreen(key: UniqueKey()),
    Navicons.profile: BrowseScreen(key: UniqueKey(), genreName: "anime"),
  };

  @override
  void initState() {
    contentScreen = iconsScreenMap[Navicons.home]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: Stack(children: [contentScreen, buildFloatedNavBar()]),
      ),
    );
  }

  Positioned buildFloatedNavBar() {
    return Positioned(
      bottom: 4,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: ColorsApp.darkGreen,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: iconsList(),
        ),
      ),
    );
  }

  List<Widget> iconsList() {
    return iconsScreenMap.entries.map((e) {
      return iconItem(e);
    }).toList();
  }

  Widget iconItem(MapEntry<String, Widget> e) {
    return InkWell(
      onTap: () {
        setState(() {
          contentScreen = e.value;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ImageIcon(
          AssetImage(e.key),
          color:
              (contentScreen == e.value) ? ColorsApp.yellow : ColorsApp.white,
          size: 24,
        ),
      ),
    );
  }
}
