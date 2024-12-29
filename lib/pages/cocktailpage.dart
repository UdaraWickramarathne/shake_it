import 'package:shake_it/service/bluetooth_configs/bluetooth_manager.dart';
import 'package:shake_it/service/custom_rect_tween.dart';
import 'package:shake_it/model/cocktail.dart';
import 'package:flutter/material.dart';

class CocktailDetailPage extends StatefulWidget {
  final Cocktail cocktail;

  const CocktailDetailPage({
    super.key,
    required this.cocktail,
  });

  @override
  State<CocktailDetailPage> createState() => _CocktailDetailPageState();
}

class _CocktailDetailPageState extends State<CocktailDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: widget.cocktail.mainColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Hero(
                    tag: widget.cocktail.imagePath,
                    createRectTween: (begin, end) {
                      return CustomRectTween(begin: begin, end: end);
                    },
                    child: Image.asset(
                      widget
                          .cocktail.imagePath, // Replace with actual image path
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.cocktail.title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: widget.cocktail.mainColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.cocktail.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            Text(
              'Ingredients:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: widget.cocktail.mainColor,
              ),
            ),
            const SizedBox(height: 10),
            ...widget.cocktail.ingredients.map((ingredient) => Text(
                  "⭐ $ingredient",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return CoinPage(
                //     cocktail: widget.cocktail,
                //   );
                // }));

                BluetoothManager.instance.sendMessage("1");
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: widget.cocktail.mainColor,
                minimumSize: const Size(double.infinity, 50),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              ),
              child: const Text('Create My Cocktail',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
