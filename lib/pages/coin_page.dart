import 'package:shake_it/model/cocktail.dart';
import 'package:shake_it/pages/preparing_page.dart';
import 'package:shake_it/service/bluetooth_configs/bluetooth_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CoinPage extends StatefulWidget {
  final Cocktail cocktail;
  const CoinPage({super.key, required this.cocktail});

  @override
  State<CoinPage> createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  int _insertedCoins = 0;

  @override
  void initState() {
    super.initState();
    _listenForCoinInput();
  }

  void _listenForCoinInput() {
    BluetoothManager.instance.connection?.input?.listen((data) {
      // Assuming the Arduino sends the number of coins inserted as a string
      String coinInput = String.fromCharCodes(data).trim();
      int coins = int.tryParse(coinInput) ?? 0;
      setState(() {
        _insertedCoins += coins;
      });

      if (_insertedCoins >= widget.cocktail.coinValue) {
        _sendCocktailCode();
      }
    });
  }

  void _sendCocktailCode() {
    BluetoothManager.instance.sendMessage(widget.cocktail.code);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return PreparingPage(
          countdownSeconds: widget.cocktail.preparationTime,
          cocktail: widget.cocktail,
        );
      },
    ));
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
          Text(
            'Coins inserted: $_insertedCoins',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
