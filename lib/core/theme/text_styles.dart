import 'package:flutter/material.dart';
import 'app_colors.dart';

class TextStyles {
  // Headlines
  static TextStyle headlineLarge = const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textColorPrimary,
  );

  static TextStyle headlineMedium = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textColorPrimary,
  );

  static TextStyle headlineSmall = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textColorPrimary,
  );

  // Titles
  static TextStyle titleLarge = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textColorPrimary,
  );

  static TextStyle titleMedium = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textColorPrimary,
  );

  static TextStyle titleSmall = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textColorPrimary,
  );

  // Body
  static TextStyle bodyLarge = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textColorPrimary,
  );

  static TextStyle bodyMedium = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textColorSecondary,
  );

  static TextStyle bodySmall = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textColorHint,
  );

  // Labels
  static TextStyle labelLarge = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textColorPrimary,
  );

  static TextStyle labelMedium = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textColorSecondary,
  );

  static TextStyle labelSmall = const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textColorHint,
  );
}
