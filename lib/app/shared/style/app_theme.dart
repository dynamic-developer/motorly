// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart';

// ignore: avoid_classes_with_only_static_members
class AppTheme {
  static final ThemeData light = ThemeData(
    primaryColor: AppColors.primary,
    accentColor: AppColors.secondary,
    errorColor: AppColors.danger,
    fontFamily: 'OpenSans',
    backgroundColor: Color(0xFFE5E5E5),
    cardColor: Colors.white,
    hoverColor: AppColors.gray70,
    canvasColor: AppColors.gray90,
    shadowColor: AppColors.gray20,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      color: AppColors.primary,
      elevation: 1,
      iconTheme: IconThemeData(color: Colors.white),
      textTheme: TextTheme(
        headline6: AppTextStyles.primaryH0Bold.copyWith(
          color: AppColors.gray90,
        ),
        bodyText2: AppTextStyles.primaryH1Medium.copyWith(
          color: AppColors.gray90,
        ),
        headline1: AppTextStyles.primaryH1Medium.copyWith(
          color: AppColors.gray90,
        ),
      ),
    ),
  );

  static final ThemeData dark = ThemeData(
    primaryColor: AppColors.primary,
    accentColor: AppColors.secondary,
    errorColor: AppColors.danger,
    shadowColor: Colors.black,
    fontFamily: 'OpenSans',
    hoverColor: AppColors.gray20,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: AppColors.gray90,
    cardColor: AppColors.backgroundCard,
    textTheme: TextTheme(
      headline6: AppTextStyles.primaryH1Medium.copyWith(color: Colors.white),
      bodyText2: AppTextStyles.primaryH1Medium.copyWith(color: Colors.white),
      headline1: AppTextStyles.primaryH1Medium.copyWith(color: Colors.white),
    ),
    backgroundColor: AppColors.gray90,
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      color: AppColors.primary,
      elevation: 1,
      iconTheme: IconThemeData(color: Colors.white),
      textTheme: TextTheme(
        headline6: AppTextStyles.primaryH0Bold.copyWith(color: Colors.white),
        bodyText2: AppTextStyles.primaryH1Medium.copyWith(color: Colors.white),
        headline1: AppTextStyles.primaryH1Medium.copyWith(color: Colors.white),
      ),
    ),
  );
}
