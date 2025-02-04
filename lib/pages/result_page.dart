import 'package:shake_it/model/cocktail.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shake_it/pages/coin_page.dart';
import 'package:shake_it/pages/homepage.dart';

class ResultPage extends StatelessWidget {
  final Cocktail cocktail;
  const ResultPage({super.key, required this.cocktail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Center(
            child: Text(
              'YOUR COCKTAIL IS READY!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 50),
          Lottie.asset(
            'assets/complete.json', // Path to the Lottie JSON file
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              // Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 49, 49, 49),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Back to Home',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
