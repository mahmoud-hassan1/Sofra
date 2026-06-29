import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';

class EmptyPosts extends StatelessWidget {
  const EmptyPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.neutralColor, width: 2.5),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.neutralColor,
                    offset: Offset(4, 4),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: const Icon(
                Icons.restaurant_rounded,
                size: 44,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Text('No Posts Yet', style: AppFonts.header.copyWith(fontSize: 22)),
            const SizedBox(height: 8),
            Text(
              'Share your first culinary masterpiece!',
              style: AppFonts.bodyMedium.copyWith(
                color: AppColors.seconderyFontColor,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
