import 'package:flutter/material.dart';
import 'package:ta_na_escola/theme/colors.dart';

import '../text_theme/text_theme.dart';

class TneAppTheme {
  TneAppTheme._();

  static ThemeData lightTheme = ThemeData(
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primaryColor, // Cor do cursor
      selectionColor: primaryColor.withValues(alpha: 0.3),
      selectionHandleColor: primaryFocusColor,
    ),

    primarySwatch: createMaterialColor(primaryColor),

    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: const Color.fromRGBO(31, 154, 30, 1),
    focusColor: Colors.white,
    fontFamily: 'roboto',
    textTheme: TneTextTheme.lightTextTheme,
    useMaterial3: true,
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: const Color.fromARGB(1, 31, 154, 30),
    focusColor: Colors.white,
    fontFamily: 'roboto',
    textTheme: TneTextTheme.darkTextTheme,
    useMaterial3: true,
  );
}
