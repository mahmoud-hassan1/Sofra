import 'package:flutter/material.dart';
import 'package:sofra/core/utils/fonts.dart';

class RecipeHeaders extends StatelessWidget {
  final String title;
  final int cookingTimeMinutes;
  final String kitchenType;

  const RecipeHeaders({
    super.key,
    required this.title,
    required this.cookingTimeMinutes,
    required this.kitchenType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: AlignmentGeometry.centerLeft,
          child: Text(title, style: AppFonts.header),
        ),
        Row(
          children: [
            Icon(Icons.timer_outlined),
            Text(" $cookingTimeMinutes mins"),
            SizedBox(width: 16),
            Icon(Icons.fireplace_outlined),
            Text(" $kitchenType"),
          ],
        ),
      ],
    );
  }
}
