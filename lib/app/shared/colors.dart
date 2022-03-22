// ignore_for_file: dead_code

import 'package:flutter/material.dart';

class AppColors {
  // Blue
  static const blueColor = Color(0xff3A86FF);
  static const blueColor70 = Color(0xff6BAAFF);
  static const blueColor50 = Color(0xff618BF4);
  static const blueColor25 = Color(0xff96B6FB);
  static const blueColor10 = Color(0xffCADBFD);
  static const blueColorTp = Color(0xffB0D7FF);
  // Yellow
  static const yellowColor = Color(0xffEBAD0D);
  static const yellowColor70 = Color(0xffF3C746);
  static const yellowColor50 = Color(0xffF9D96B);
  static const yellowColor25 = Color(0xffFDEA9D);
  static const yellowColor10 = Color(0xffFEF6CE);
  static const yellowColor20 = Color(0xffF8BE4A);
  // Red
  static const redColor = Color(0xffF25724);
  static const redColor70 = Color(0xffF78B59);
  static const redColor50 = Color(0xffFBAC7A);
  static const redColor25 = Color(0xffFDCFA7);
  static const redColor10 = Color(0xffFEEAD3);
  // green
  static const greenColor = Color(0xff4BA282);
  static const greenColor70 = Color(0xff76C7A1);
  static const greenColor50 = Color(0xff99E3B9);
  static const greenColor25 = Color(0xffC0F5D2);
  static const greenColor10 = Color(0xffDFFAE5);
  // Black
  static const blackColor = Color(0xff000000);
  static const blackColor70 = Color(0xff666666);
  static const blackColor50 = Color(0xffB2B2B2);
  static const blackColor25 = Color(0xffE5E5E5);
  static const blackColor10 = Color(0xffF2F2F2);

  static const Map<int, Color> colorScratch = {
    50: Color.fromRGBO(7, 45, 114, .1),
    100: Color.fromRGBO(7, 45, 114, .2),
    200: Color.fromRGBO(7, 45, 114, .3),
    300: Color.fromRGBO(7, 45, 114, .4),
    400: Color.fromRGBO(7, 45, 114, .5),
    500: Color.fromRGBO(7, 45, 114, .6),
    600: Color.fromRGBO(7, 45, 114, .7),
    700: Color.fromRGBO(7, 45, 114, .8),
    800: Color.fromRGBO(7, 45, 114, .9),
    900: Color.fromRGBO(7, 45, 114, 1),
  };

  static ThemeData themeData(BuildContext context) {
    const isDarkTheme = false;

    return ThemeData(
      fontFamily: 'DMSans-Regular',
      primarySwatch: const MaterialColor(
        0xff3A86FF,
        AppColors.colorScratch,
      ),
      primaryColor: blueColor,
      bottomAppBarColor: Colors.white.withOpacity(0.05),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white.withOpacity(0.05),
      ),
      focusColor: blueColor,
      bottomAppBarTheme:
          BottomAppBarTheme(color: Colors.white.withOpacity(0.05)),
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: isDarkTheme
                ? const ColorScheme.dark()
                : const ColorScheme.light(),
          ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.transparent,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: isDarkTheme ? Colors.white : Colors.black,
      ),
    );
  }
}
