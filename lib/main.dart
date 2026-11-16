import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/menu.dart';

void main() {
  runApp(const MyApp());
}

class AppColors {
  static const Color oldCopper = Color(0xFF775537);
  static const Color butterYellow = Color(0xFFFBE29D);
  static const Color nebula = Color(0xFFC0DDDA);
  static const Color seashell = Color(0xFFF1F1F1);
  static const Color dustyPink = Color(0xFFE8B4B8);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPortfolio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.oldCopper,
          primary: AppColors.oldCopper,
          secondary: AppColors.butterYellow,
          surface: AppColors.seashell,
        ),
        scaffoldBackgroundColor: AppColors.seashell,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.oldCopper,
          foregroundColor: AppColors.seashell,
        ),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}