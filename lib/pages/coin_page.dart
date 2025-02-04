import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shake_it/model/cocktail.dart';
import 'package:shake_it/pages/preparing_page.dart';
import 'package:shake_it/service/bluetooth_configs/bluetooth_data_provider.dart';
import 'package:shake_it/service/bluetooth_configs/bluetooth_manager.dart';

class CoinPage extends StatefulWidget {
  final Cocktail cocktail;
  const CoinPage({super.key, required this.cocktail});

  @override
  State<CoinPage> createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  late BluetoothDataProvider bluetoothDataProvider;
  int insertedCoins = 0;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent, // Your desired color
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bluetoothDataProvider =
        Provider.of<BluetoothDataProvider>(context, listen: false);
    bluetoothDataProvider.addListener(_handleBluetoothData);
  }

  @override
  void dispose() {
    bluetoothDataProvider.removeListener(_handleBluetoothData);
    insertedCoins = 0;
    super.dispose();
  }

  void _handleBluetoothData() {
    final String data = bluetoothDataProvider.receivedData;
    dev.log('Current Cocktail Coin Value: ${widget.cocktail.coinValue}');

    if (data == "COIN") {
      setState(() => insertedCoins++);

      if (insertedCoins >= widget.cocktail.coinValue) {
        _sendCocktailCode();
      }
    }
  }

  void _sendCocktailCode() {
    BluetoothManager.instance.sendMessage(widget.cocktail.code);
    Navigator.pushReplacement(
      // Key change here
      context,
      MaterialPageRoute(
        builder: (context) => PreparingPage(
          countdownSeconds: widget.cocktail.preparationTime,
          cocktail: widget.cocktail,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Make the scaffold background transparent

      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange,
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'INSERT ${widget.cocktail.coinValue} ${widget.cocktail.coinValue > 1 ? 'COINS' : 'COIN'}',
                style:
                    const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 50),
            Lottie.asset(
              'assets/coin_animation.json',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text('Inserted Coins Count', style: TextStyle(fontSize: 20)),
            Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 6, horizontal: 20), // Padding inside the container
              decoration: BoxDecoration(
                color: Colors.grey.shade300, // Background color
                borderRadius: BorderRadius.circular(12.0), // Rounded corners
                border: Border.all(
                    color: Colors.grey.shade600,
                    width: 2), // Border color and width
              ),
              child: Text(
                '$insertedCoins',
                style: const TextStyle(
                  fontSize: 20, // Text size
                  fontWeight: FontWeight.bold, // Text weight
                  color: Colors.black, // Text color
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
