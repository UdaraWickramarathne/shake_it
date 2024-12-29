import 'package:shake_it/model/cocktail.dart';
import 'package:flutter/material.dart';

final List<Cocktail> _cocktails = [
  Cocktail(
    title: 'Blue Lagoon',
    description:
        'A refreshing mix of vodka, rum, and gin, perfect for those who enjoy light and zesty cocktails.',
    ingredients: ['Vodka', 'Rum', 'Gin'],
    mainColor: Colors.blue,
    imagePath: 'assets/blue_lagoon.png',
    code: 'BL001',
    coinValue: 2,
    preparationTime: 5,
  ),
  Cocktail(
    title: 'Sunset Bliss',
    description:
        'A bold combination of whiskey, vodka, and rum, offering a smooth yet robust flavor profile.',
    ingredients: ['Whiskey', 'Vodka', 'Rum'],
    mainColor: Colors.orange,
    imagePath: 'assets/sunset_bliss.png',
    code: 'SB002',
    coinValue: 1,
    preparationTime: 7,
  ),
  Cocktail(
    title: 'Emerald Mojito',
    description:
        'An aromatic blend of gin, rum, and whiskey, ideal for fans of herbal and earthy undertones.',
    ingredients: ['Gin', 'Rum', 'Whiskey'],
    mainColor: Colors.green,
    imagePath: 'assets/emerald_mojito.png',
    code: 'EM003',
    coinValue: 3,
    preparationTime: 6,
  ),
  Cocktail(
    title: 'Ruby Royale',
    description:
        'A balanced powerhouse combining vodka, rum, gin, and whiskey in perfect harmony. Great for adventurous cocktail enthusiasts.',
    ingredients: ['Vodka', 'Rum', 'Gin', 'Whiskey'],
    mainColor: Colors.red,
    imagePath: 'assets/ruby_royal.png',
    code: 'RR004',
    coinValue: 2,
    preparationTime: 8,
  ),
  Cocktail(
    title: 'Golden Glow',
    description:
        'A crisp and clean mix of vodka and gin, emphasizing their classic botanical and neutral flavors.',
    ingredients: ['Vodka', 'Gin'],
    mainColor: Colors.amber,
    imagePath: 'assets/golden_glow.png',
    code: 'GG005',
    coinValue: 1,
    preparationTime: 4,
  ),
  Cocktail(
    title: 'Purple Paradise',
    description:
        'A warm and rich pairing of rum and whiskey, perfect for sipping slowly and enjoying the depth of flavor.',
    ingredients: ['Rum', 'Whiskey'],
    mainColor: Colors.deepPurple,
    imagePath: 'assets/purple_paradise.png',
    code: 'PP006',
    coinValue: 3,
    preparationTime: 9,
  ),
];

List<Cocktail> getCocktails() {
  return _cocktails;
}
