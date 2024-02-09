import 'package:flutter/material.dart';
import 'package:kbcquiz/Themes/appColors.dart';

class Themes {
  static final lighTheme =
      ThemeData.light().copyWith(scaffoldBackgroundColor: AppColors.whiteColor);

  static final darkTheme =
      ThemeData.dark().copyWith(scaffoldBackgroundColor: AppColors.blackColor);
}
