import 'package:flutter/material.dart';
import 'package:movies_flutter/_core/constants/colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(colorScheme: ColorsApp.colorScheme),
      home: Scaffold(body: Center(child: Image.asset("assets/app_img_4x.png"))),
    );
  }
}
