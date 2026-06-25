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
  static TextStyle get bodyMedium => const TextStyle(
    fontFamily: AppFonts.hankenGrotesk,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryFontColor,
  );

  static TextStyle get header => const TextStyle(
    fontFamily: AppFonts.bricolageGrotesque ,
    fontSize: 32 ,
    fontWeight: FontWeight.w700  
  );
}
