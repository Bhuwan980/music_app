import 'package:client/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark().copyWith(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor:
          Pallete.borderColor, // Change this to your preferred color
    ),
    appBarTheme: AppBarTheme(backgroundColor: Pallete.backgroundColor),
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Pallete.gradient1),
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Pallete.greyColor),
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
    ),
  );
}
