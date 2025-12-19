import 'package:flutter/material.dart';

const primaryColor = Color.fromARGB(255, 0, 69, 35);
const primaryFocusColor = Color.fromRGBO(0, 125, 68, 1);
const accentColor = Color.fromRGBO(29, 172, 16, 1);
const secondaryColor = Colors.white;
const black = Colors.black;
const alertColor = Colors.red;

const transparent = Colors.transparent;

const warning = Colors.amber;

const veryDarkBlue = Color.fromRGBO(0, 13, 29, 1);
const mediumDarkBlue = Color.fromRGBO(0, 31, 59, 1);
const grey = Color.fromRGBO(0, 0, 0, 0.6);
const mediumGrey = Color.fromRGBO(0, 0, 0, 0.25);
const lightGrey = Color.fromRGBO(0, 0, 0, 0.1);

const LinearGradient primaryGradient = LinearGradient(
  colors: [primaryFocusColor, primaryColor],
);
const secondaryGradient = LinearGradient(
  colors: [accentColor, primaryFocusColor],
);
final greyGradient = LinearGradient(
  colors: [Colors.white, Colors.grey.shade300],
);

MaterialColor createMaterialColor(Color color) {
  final strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (final strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }

  return MaterialColor(color.value, swatch);
}
