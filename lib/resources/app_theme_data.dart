import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData lightTheme = ThemeData(
    primaryColor: TaylorLightColors.taylorPrimaryShadeTwo,
    brightness: Brightness.light,
    fontFamily: 'SuisseIntl',
    textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 72.0,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: TaylorLightColors.taylorDarkColor),
        displayMedium: TextStyle(
            fontSize: 48.0, fontWeight: FontWeight.bold, color: Colors.white),
        labelSmall: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: TaylorLightColors.primary),
        titleMedium: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
        bodyMedium: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: TaylorLightColors.taylorDarkColor)),
    cardTheme: CardTheme(color: Colors.white));
