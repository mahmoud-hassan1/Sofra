import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';

class PostTag extends StatelessWidget {
  final String label;
  final IconData? icon;
  const PostTag({super.key, required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.shade100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.neutralColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: 11), const SizedBox(width: 3)],
          Text(
            label.toUpperCase(),
            style: AppFonts.bodyMedium.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
