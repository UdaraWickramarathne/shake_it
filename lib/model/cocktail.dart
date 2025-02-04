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


  //create setter for cocktail
  Cocktail copyWith({
    String? title,
    String? description,
    List<String>? ingredients,
    MaterialColor? mainColor,
    String? imagePath,
    String? code,
    int? coinValue,
    int? preparationTime,
  }) {
    return Cocktail(
      title: title ?? this.title,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
      mainColor: mainColor ?? this.mainColor,
      imagePath: imagePath ?? this.imagePath,
      code: code ?? this.code,
      coinValue: coinValue ?? this.coinValue,
      preparationTime: preparationTime ?? this.preparationTime,
    );
  }
}
