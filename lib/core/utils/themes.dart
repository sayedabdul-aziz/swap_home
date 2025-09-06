import 'package:flutter/material.dart';
import 'package:swap_ui/core/constants/app_fonts.dart';
import 'package:swap_ui/core/utils/colors.dart';

class AppThemes {
  static get lightTheme => ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundColor,
          foregroundColor: AppColors.blackColor,
          surfaceTintColor: Colors.transparent,
        ),
        fontFamily: AppFonts.montserrat,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          onSurface: AppColors.blackColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            foregroundColor: AppColors.blackColor,
          ),
        ),
      );
}
