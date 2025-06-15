import 'package:flutter/material.dart';
import 'package:movies_flutter/_core/constants/app_routs.dart';
import 'package:movies_flutter/_core/constants/app_style.dart';
import 'package:movies_flutter/_core/constants/colors.dart';
import 'package:movies_flutter/feat/profile/presentation/providers/profile_provider.dart';
import 'package:movies_flutter/feat/profile/presentation/widgets/custom_elevated_buttom.dart';
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
          Text('Watch List', 
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
          Text('History', 
            style: AppStyle.textTheme.bodySmall?.copyWith(fontSize: 12),
          ),
        ],
      ),
    ),
  ];

  final List<Widget> _tabsBody = [
    ListView(shrinkWrap: true, children: [Image.asset('assets/Empty 1.png')]),
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
              buildProfileDetails(),
              SizedBox(height: 23),
              Row(
                children: [
                  buildElevatedButtonEditProfile(),
                  SizedBox(width: 10),
                  buildBuildElevatedButtonExit(),
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
      builder: (context, profileProvider, child) => Row(
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
              Text(profileProvider.userName, style: AppStyle.textTheme.titleMedium),
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
        AppRouts.updateProfile(),
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
    onClick: () {},
    text: 'Exit',
    textStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 20,
      color: ColorsApp.white,
    ),
    backgroundColor: ColorsApp.red2,
  );
}
