import 'dart:async';
import 'dart:typed_data';

import 'package:provider/provider.dart';
import 'package:shake_it/model/cocktail.dart';
import 'package:shake_it/pages/preparing_page.dart';
import 'package:shake_it/service/bluetooth_configs/bluetooth_data_provider.dart';
import 'package:shake_it/service/bluetooth_configs/bluetooth_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:developer' as dev;

class CoinPage extends StatefulWidget {
  final Cocktail cocktail;
  const CoinPage({super.key, required this.cocktail});

  @override
  State<CoinPage> createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  late BluetoothDataProvider bluetoothDataProvider;
  int insertedCoins = 0; // Counter for inserted coin

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bluetoothDataProvider =
        Provider.of<BluetoothDataProvider>(context, listen: false);
    bluetoothDataProvider.addListener(_handleBluetoothData);
  }

  @override
  void dispose() {
    // Remove the listener to avoid memory leaks
    bluetoothDataProvider.removeListener(_handleBluetoothData);
    insertedCoins = 0;
    super.dispose();
  }

  void _handleBluetoothData() {
    // Assuming each receivedData represents one coin insertion
    final String data = bluetoothDataProvider.receivedData;
    dev.log(data);

    if (data.isNotEmpty && data == "COIN") {
      setState(() {
        insertedCoins++;
      });

      // dev.log('Inserted Coins: $insertedCoins');

      // Check if required coins are inserted
      if (insertedCoins >= widget.cocktail.coinValue) {
        _sendCocktailCode();
      }
    }
  }

  void _sendCocktailCode() {
    insertedCoins = 0;
    BluetoothManager.instance.sendMessage(widget.cocktail.code);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PreparingPage(
            countdownSeconds: widget.cocktail.preparationTime,
            cocktail: widget.cocktail,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              'INSERT ${widget.cocktail.coinValue} ${widget.cocktail.coinValue > 1 ? 'COINS' : 'COIN'}',
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 50),
          Lottie.asset(
            'assets/coin_animation.json', // Path to the Lottie JSON file
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          Text(insertedCoins.toString())
        ],
      ),
    );
  }
}
