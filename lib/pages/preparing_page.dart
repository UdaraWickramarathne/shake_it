import 'dart:async';
import 'package:shake_it/model/cocktail.dart';
import 'package:shake_it/pages/result_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PreparingPage extends StatefulWidget {
  final int countdownSeconds;
  final Cocktail cocktail;

  const PreparingPage(
      {super.key, required this.countdownSeconds, required this.cocktail});

  @override
  State<PreparingPage> createState() => _PreparingPageState();
}

class _PreparingPageState extends State<PreparingPage> {
  late int _remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.countdownSeconds;
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ResultPage(
            cocktail: widget.cocktail,
          );
        }));
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Center(
            child: Text(
              'PREPARING YOUR COCKTAIL',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 50),
          Lottie.asset(
            'assets/cocktail.json', // Path to the Lottie JSON file
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 50),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Time left: $_remainingSeconds s',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
