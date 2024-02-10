import 'package:flutter/material.dart';
import 'package:kbcquiz/Themes/appColors.dart';

class Themes {
  static final lighTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: AppColors.whiteColor,
      appBarTheme: const AppBarTheme(
          color: AppColors.purpleColor, centerTitle: true, elevation: 0),
      textTheme: const TextTheme(
          displayLarge: TextStyle(
              color: AppColors.blackColor,
              fontSize: 18,
              fontWeight: FontWeight.bold),
          labelLarge: TextStyle(
              color: AppColors.blackColor,
              fontSize: 25,
              fontWeight: FontWeight.bold),
          labelMedium: TextStyle(
            color: AppColors.blackColor,
            fontSize: 16,
          )));

  static final darkTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppColors.blackColor,
      appBarTheme: const AppBarTheme(
          color: AppColors.black54Color, centerTitle: true, elevation: 0),
      textTheme: const TextTheme(
          displayLarge: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.bold),
          labelLarge: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 25,
              fontWeight: FontWeight.bold),
          labelMedium: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 16,
          )));
}
