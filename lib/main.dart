import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:movies_flutter/feat/auth/presentation/error_screen.dart';
import 'package:movies_flutter/feat/auth/presentation/forget_password.dart';
import 'package:movies_flutter/feat/auth/presentation/login.dart';
import 'package:movies_flutter/feat/auth/presentation/register.dart';
import 'package:movies_flutter/feat/auth/presentation/update_profile.dart';
import 'package:movies_flutter/_core/constants/nav_icons.dart';
import 'package:movies_flutter/_resources/common_state_holders/cubit/l10n_cubit.dart';
import 'package:movies_flutter/_resources/helpers/shared_prefs.dart';
import 'package:movies_flutter/feat/browse/presentation/screens/browse_screen.dart';
import 'package:movies_flutter/feat/nav_screen.dart';
import 'package:movies_flutter/feat/search/presentation/screens/search_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies_flutter/generated/l10n.dart';
import 'package:movies_flutter/_core/constants/colors.dart';
import 'package:movies_flutter/di/di.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  Di.setupDependancyInjection();
  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) => ErrorScreen();
   await SharedPrefs.initSharedPrefs();

  Di.setupDependancyInjection();
  runApp(const MainApp());

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

    return BlocProvider(
      create: (context) => L10nCubit(),
      child: BlocBuilder<L10nCubit, String>(
        builder: (context, l10nState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            theme: ThemeData(
              colorScheme: ColorsApp.colorScheme,
              scaffoldBackgroundColor: ColorsApp.black,
            ),
            //  Change Locale from here
            //  We'll gonna add state_management to be able to access it from any screen
            // * DONE
            locale: Locale(l10nState),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            home: SafeArea(
              child:
                  //  TestL10nScreen(),
                  NavScreen(),
            ),
          );
        },
      ),

    );
  }
}

class TestL10nScreen extends StatelessWidget {
  const TestL10nScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<L10nCubit>().toggle();
          },
          child: Text(S.of(context).action),
        ),
      ),
    );
  }
}
