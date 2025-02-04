import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shake_it/pages/splash_screen.dart';
import 'package:shake_it/service/bluetooth_configs/bluetooth_data_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => BluetoothDataProvider(),
      child: const CocktailApp(),
    ),
  );
}

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
