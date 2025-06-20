import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_flutter/_core/constants/app_routs.dart';
import 'package:movies_flutter/_core/constants/app_style.dart';
import 'package:movies_flutter/_core/constants/colors.dart';
import 'package:movies_flutter/_resources/common_widgets/movies_items_list.dart';
import 'package:movies_flutter/_resources/helpers/shared_prefs.dart';
import 'package:movies_flutter/_resources/state_ui.dart';
import 'package:movies_flutter/common/movies_list/models/movie.dart';
import 'package:movies_flutter/feat/auth/presentation/login.dart';
import 'package:movies_flutter/feat/auth/presentation/update_profile.dart';
import 'package:movies_flutter/feat/profile/presentation/providers/profile_provider.dart';
import 'package:movies_flutter/feat/profile/presentation/state_holders/cubit/profile_cubit.dart';
import 'package:movies_flutter/feat/profile/presentation/widgets/custom_elevated_buttom.dart';
import 'package:movies_flutter/generated/l10n.dart';
import 'package:provider/provider.dart';

class ProfileTap extends StatefulWidget {
  const ProfileTap({super.key});

  @override
  State<ProfileTap> createState() => _ProfileTapState();
}

class _ProfileTapState extends State<ProfileTap>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    context.read<ProfileCubit>().getFavoriteMovies();
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        context.read<ProfileCubit>().getFavoriteMovies();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Tab> _tabs = [
    Tab(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.list, color: ColorsApp.yellow, size: 20),
          SizedBox(height: 4),
          Text(
            'Watch List',
            style: AppStyle.textTheme.bodySmall?.copyWith(fontSize: 12),
          ),
        ],
      ),
    ),
    Tab(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder, color: ColorsApp.yellow, size: 20),
          SizedBox(height: 4),
          Text(
            'History',
            style: AppStyle.textTheme.bodySmall?.copyWith(fontSize: 12),
          ),
        ],
      ),
    ),
  ];

  final List<Widget> _tabsBody = [
    BlocBuilder<ProfileCubit, StateUi<List<MovieDM>, String>>(
      builder: (context, state) {
        if (state is ErrorState) {
          return Center(child: Text(state.error ?? "error"));
        } else if (state is SuccessState) {
          return MoviesItemsList(
            numOfTiles: 3,
            movies: state.data ?? [],
            limit: ((state.data?.length) ?? 0) + 1,
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    ),
    ListView(shrinkWrap: true, children: [Image.asset('assets/Empty 1.png')]),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsApp.gray,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 8),
              buildProfileDetails(),
              SizedBox(height: 23),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: buildElevatedButtonEditProfile(),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: buildBuildElevatedButtonExit(),
                  ),
                ],
              ),
              buildTabBar(),
              buildTabBarView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabBarView() {
    return Expanded(
      child: TabBarView(controller: _tabController, children: _tabsBody),
    );
  }

  Widget buildTabBar() {
    return Container(
      height: 70,
      child: TabBar(
        controller: _tabController,
        tabs: _tabs,
        padding: EdgeInsets.symmetric(vertical: 5),
        indicatorColor: ColorsApp.yellow,
        dividerHeight: 0,
      ),
    );
  }

  Widget buildProfileDetails() {
    return Consumer<ProfileProvider>(
      builder:
          (context, profileProvider, child) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: ColorsApp.gray,
                    child: Image.asset(profileProvider.selectedAvatar),
                  ),
                  SizedBox(height: 15),
                  Text(
                    profileProvider.userName,
                    style: AppStyle.textTheme.titleMedium,
                  ),
                ],
              ),
              SizedBox(width: 26),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('12', style: AppStyle.textTheme.labelLarge),
                  Text('Wish List', style: AppStyle.textTheme.titleMedium),
                ],
              ),
              SizedBox(width: 15),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('10', style: AppStyle.textTheme.labelLarge),
                  Text('History', style: AppStyle.textTheme.titleMedium),
                ],
              ),
            ],
          ),
    );
  }

  Widget buildElevatedButtonEditProfile() => CustomElevatedButton(
    horizontal: 26,
    vertical: 12,
    onClick: () async {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UpdateProfile()),
      );
    },
    text: 'Edit Profile',
    textStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 20,
      color: ColorsApp.black,
    ),
    backgroundColor: ColorsApp.yellow,
  );

  Widget buildBuildElevatedButtonExit() => CustomElevatedButton(
    horizontal: 16,
    vertical: 12,
    onClick: () {
      exitAccout();
    },
    text: S.of(context).exit,
    textStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 20,
      color: ColorsApp.white,
    ),
    backgroundColor: ColorsApp.red2,
  );

  Future<void> exitAccout() async {
    bool isExited = await SharedPrefs.exitAccount();
    if (mounted) {
      if (isExited) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Error")));
    }
  }
}
