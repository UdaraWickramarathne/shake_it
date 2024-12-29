import 'package:flutter/material.dart';

class Cocktail {
  final String title;
  final String description;
  final List<String> ingredients;
  final MaterialColor mainColor;
  final String imagePath;
  final String code;
  final int coinValue;
  final int preparationTime;

  Cocktail({
    required this.title,
    required this.description,
    required this.ingredients,
    required this.mainColor,
    required this.imagePath,
    required this.code,
    required this.coinValue,
    required this.preparationTime,
  });
}
