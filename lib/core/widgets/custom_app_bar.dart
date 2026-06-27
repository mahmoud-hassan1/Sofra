import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(77);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 77,
      leadingWidth: 200,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Text(
          "Sofra",
          style: AppFonts.header.copyWith(color: AppColors.backGroundColor),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Icon(Icons.search, size: 28, color: AppColors.backGroundColor),
        ),
      ],
      backgroundColor: AppColors.seconderyFontColor,
    );
  }
}
