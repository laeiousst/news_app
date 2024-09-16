import 'package:flutter/material.dart';
import 'package:news_app/src/core/theme/app_colors.dart';

final appTheme = ThemeData(
  fontFamily: 'Lora',
  brightness: Brightness.light,
  primarySwatch: Colors.indigo,
  primaryColor: const Color.fromARGB(255, 42, 183, 196),
  primaryColorLight: const Color(0xFFA9BCFD).withOpacity(0.2),
  primaryColorDark: const Color(0xFF3B3E58),
  cardColor: const Color(0xFFFFFFFF),
  scaffoldBackgroundColor: AppColors.lightGray,
  dividerTheme: const DividerThemeData(
    color: AppColors.darkGray,
  ),
  colorScheme: const ColorScheme.light(primary: AppColors.primary),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
    },
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 38,
      fontWeight: FontWeight.w600,
      color: AppColors.darkGray,
    ),
    displayMedium: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w600,
      color: AppColors.darkGray,
    ),
    displaySmall: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w600,
      color: AppColors.darkGray,
    ),
    headlineLarge: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w600,
      color: AppColors.darkGray,
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.darkGray,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.darkGray,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppColors.darkGray,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.darkGray,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.darkGray,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.darkGray,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.darkGray,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.darkGray,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.gray,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.gray,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: AppColors.gray,
    ),
  ),
);
