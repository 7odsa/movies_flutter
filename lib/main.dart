import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:movies_flutter/generated/l10n.dart';

import 'package:movies_flutter/_core/constants/colors.dart';
import 'package:movies_flutter/di/di.dart';
import 'package:movies_flutter/feat/feat_templete/presentation/screens/auth/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Di.setupDependancyInjection();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(colorScheme: ColorsApp.colorScheme),
      // * Change Locale from here
      // * We'll gonna add state_management to be able to access it from any screen
      locale: Locale('ar'),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: Scaffold(body: LoginScreen()),
    );
  }
}
