import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_flutter/_core/constants/colors.dart';
import 'package:movies_flutter/_core/constants/nav_icons.dart';
import 'package:movies_flutter/_resources/common_state_holders/nav_screen_sh/cubit/nav_screen_cubit.dart';
import 'package:movies_flutter/feat/browse/presentation/screens/browse_screen.dart';
import 'package:movies_flutter/feat/home/presentation/screens/home_screen.dart';
import 'package:movies_flutter/feat/profile/presentation/screens/profile_tap.dart';
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
    Navicons.home: HomeScreen(),
    Navicons.search: SearchScreen(),
    Navicons.browse: BrowseScreen(),
    Navicons.profile: ProfileTap(),
  };

  @override
  void initState() {
    contentScreen = iconsScreenMap[Navicons.home]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavScreenCubit(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: BlocBuilder<NavScreenCubit, Widget>(
            builder: (context, state) {
              return Stack(children: [state, buildFloatedNavBar()]);
            },
          ),
        ),
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
    return BlocBuilder<NavScreenCubit, Widget>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            setState(() {
              context.read<NavScreenCubit>().changeScreen(e.value);
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ImageIcon(
              AssetImage(e.key),
              color:
                  (state.runtimeType == e.value.runtimeType)
                      ? ColorsApp.yellow
                      : ColorsApp.white,
              size: 24,
            ),
          ),
        );
      },
    );
  }
}
