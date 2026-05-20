import 'package:flutter/material.dart';
import 'package:news_app/features/splash/pages/splash_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF1B6B6F);

    return MaterialApp(
      title: 'Space Report App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
        scaffoldBackgroundColor: const Color(0xFFF6F8FA),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0.5,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      home: const SplashPage(),
    );
  }
}
