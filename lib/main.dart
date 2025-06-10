import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movies_flutter/_core/constants/nav_icons.dart';
import 'package:movies_flutter/feat/browse/presentation/screens/browse_screen.dart';
import 'package:movies_flutter/feat/nav_screen.dart';
import 'package:movies_flutter/feat/search/presentation/screens/search_screen.dart';

import 'package:movies_flutter/generated/l10n.dart';

import 'package:movies_flutter/_core/constants/colors.dart';
import 'package:movies_flutter/di/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Di.setupDependancyInjection();

  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // TODO: for now and change it later to home screen
  late Widget contentScreen;

  // TODO
  Map<String, Widget> iconsScreenMap = {
    Navicons.home: BrowseScreen(),
    Navicons.search: SearchScreen(),
    Navicons.browse: BrowseScreen(),
    Navicons.profile: BrowseScreen(),
  };

  @override
  void initState() {
    contentScreen = iconsScreenMap[Navicons.home]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      home: SafeArea(child: NavScreen()),
    );
  }
}
