import 'package:shake_it/service/custom_rect_tween.dart';
import 'package:shake_it/model/cocktail.dart';
import 'package:shake_it/pages/cocktailpage.dart';
import 'package:flutter/material.dart';

class CocktailWidget extends StatelessWidget {
  final Cocktail cocktail;

  const CocktailWidget({
    super.key,
    required this.cocktail,
  });

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      width: deviceWidth / 2 - 30,
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            cocktail.mainColor.shade100,
            cocktail.mainColor.shade500,
          ],
          tileMode: TileMode.mirror,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: cocktail.imagePath,
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin, end: end);
            },
            child: Image.asset(
              cocktail.imagePath, // Replace with actual image path
              width: 150,
              height: 150,
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              cocktail.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CocktailDetailPage(cocktail: cocktail);
              }));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 49, 49, 49),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'More Details',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
