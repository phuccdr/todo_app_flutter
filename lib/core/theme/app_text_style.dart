import 'package:flutter/material.dart';
import 'package:todoapp/core/theme/app_colors.dart';

class AppTextStyle {
  static const titleLarge = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 32,
    color: AppColors.textTitle,
  );

  static const titleMediumBold = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: AppColors.textTitle,
  );
  static const TextStyle titleSmall = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 20,
    color: AppColors.textTitle,
  );

  static const TextStyle body = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.textPrimary,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18,
    color: AppColors.textTitle,
  );

  static const TextStyle bodySmall = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.textPrimary,
  );
  static const TextStyle bodySmallBold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );
  static const TextStyle labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.border,
  );

  static const hint = TextStyle(
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
    fontSize: 16,
  );
}
