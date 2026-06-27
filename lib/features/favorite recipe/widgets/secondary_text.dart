import 'package:flutter/material.dart';
import 'package:sofra/core/utils/fonts.dart';

class SecondaryText extends StatelessWidget {
  const SecondaryText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Your personal stash of top-tier bites. Don't lose these gems.",
      style: AppFonts.bodyMedium.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
