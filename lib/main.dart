import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movies_flutter/_resources/common_state_holders/nav_screen_sh/cubit/nav_screen_cubit.dart';
import 'package:movies_flutter/feat/auth/presentation/error_screen.dart';
import 'package:movies_flutter/_resources/common_state_holders/l10n_sh/cubit/l10n_cubit.dart';
import 'package:movies_flutter/_resources/helpers/shared_prefs.dart';
import 'package:movies_flutter/feat/auth/presentation/login.dart';
import 'package:movies_flutter/feat/home/presentation/bloc/movie_bloc.dart';
import 'package:movies_flutter/feat/nav_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';
import 'package:movies_flutter/feat/profile/presentation/providers/profile_provider.dart';

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
  await SharedPrefs.initSharedPrefs();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        // Add other providers here if needed
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late Widget screen;
  @override
  void initState() {
    super.initState();
    final String? token = SharedPrefs.getUserToken();
    screen = (token != null) ? NavScreen() : Login();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc(sl()),
      child: BlocProvider(
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
                    // HomeScreen(),
                    screen,
                // MovieDetailsScreen(movieId: 1),
              ),
            );
          },
        ),
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
            context.read<L10nCubit>().switchLanguage(EnumLang.en);
          },
          child: Text(S.of(context).action),
        ),
      ),
    );
  }
}
