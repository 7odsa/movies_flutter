import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movies_flutter/feat/browse/presentation/screens/browse_screen.dart';

import 'package:movies_flutter/generated/l10n.dart';

import 'package:movies_flutter/_core/constants/colors.dart';
import 'package:movies_flutter/di/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Di.setupDependancyInjection();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  int selectedIcon = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    List<Widget> btmNavIcons = [
      ImageIcon(
        AssetImage("assets/home_icon.png"),
        color: Colors.red,
        size: 24,
      ),
      ImageIcon(
        AssetImage("assets/search_icon.png"),
        color: Colors.red,
        size: 24,
      ),
      ImageIcon(
        AssetImage("assets/browse_icon.png"),
        color: Colors.red,
        size: 24,
      ),
      ImageIcon(
        AssetImage("assets/profile_icon.png"),
        color: Colors.red,
        size: 24,
      ),
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorsApp.colorScheme,
        scaffoldBackgroundColor: ColorsApp.black,
      ),
      // * Change Locale from here
      // * We'll gonna add state_management to be able to access it from any screen
      locale: Locale('en'),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Stack(
              children: [BrowseScreen(), buildFloatedNavBar(btmNavIcons)],
            ),
          ),
        ),
      ),
    );
  }

  Positioned buildFloatedNavBar(List<Widget> btmNavIcons) {
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
        // !Todo Try Tab bar here
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: btmNavIcons,
        ),
      ),
    );
  }
}
