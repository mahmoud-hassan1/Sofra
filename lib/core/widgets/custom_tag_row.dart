import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';

class CustomTagRow extends StatelessWidget {
  const CustomTagRow({
    super.key,
    required this.label,
    this.icon,
    this.isActive = true,
    this.onTap,
    this.color,
  });

  final String label;
  final Icon? icon;
  final bool isActive;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
          color: color ??
              (isActive
                  ? AppColors.secondaryColor[300]
                  : AppColors.backGroundColor),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: AppColors.neutralColor, width: 2),
          boxShadow: const [
            BoxShadow(
              color: AppColors.neutralColor,
              offset: Offset(4, 6),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[icon!, const SizedBox(width: 4)],
            Text(label, style: AppFonts.bodyMedium),
          ],
        ),
      ),
    );
  }
}
