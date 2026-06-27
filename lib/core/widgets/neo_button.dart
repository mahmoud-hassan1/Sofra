import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';

class NeoButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? bgColor;
  final double shadow;

  const NeoButton({
    super.key,
    required this.text,
    required this.onTap,
    this.bgColor,
    this.shadow = 8, 
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.primaryColor[500]!,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.neutralColor,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.neutralColor,
              offset: Offset(shadow, shadow),
              blurRadius: 0,
            ),
          ],
        ),
        child: Text(
          text,
          style: AppFonts.bodyMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
