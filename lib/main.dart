import 'package:flutter/material.dart';
import 'package:shake_it/pages/splash_screen.dart';

void main() => runApp(const CocktailApp());

class CocktailApp extends StatelessWidget {
  const CocktailApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: const SplashScreen(),
    );
  }
}
