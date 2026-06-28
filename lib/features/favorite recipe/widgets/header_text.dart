import 'dart:math' as math;
import 'package:flutter/cupertino.dart';

import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            "SAVED MUNCHIES",
            style: AppFonts.header.copyWith(fontSize: 38),
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -15),
          child: Transform.rotate(
            angle: 12 * math.pi / 180,
            child: Icon(
              CupertinoIcons.money_dollar,
              size: 60,
              color: AppColors.seconderyFontColor[500],
            ),
          ),
        ),
      ],
    );
  }
}
