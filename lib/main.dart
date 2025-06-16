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
  ErrorWidget.builder =
      (FlutterErrorDetails flutterErrorDetails) => ErrorScreen();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
      home: Register(),
      // SafeArea(
      //   child: Scaffold(
      //     body: Padding(
      //       padding: const EdgeInsets.all(16.0),
      //       child: BrowseScreen(),
      //     ),
      //   ),
      // ),
    );
  }
}
