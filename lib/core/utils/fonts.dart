import 'package:flutter/material.dart';

import 'package:sofra/core/utils/colors.dart';

class AppFonts {
  AppFonts._();

  static const String bricolageGrotesque = 'BricolageGrotesque';
  static const String hankenGrotesk = 'HankenGrotesk';
  static const String robotoCondensed = 'RobotoCondensed';
  static TextStyle label = TextStyle(
    fontFamily: AppFonts.robotoCondensed,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryFontColor,
  );
  static TextStyle bodyMedium = TextStyle(
    fontFamily: AppFonts.hankenGrotesk,
    fontSize: 16,
    height: 24,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryFontColor,
  );
}
