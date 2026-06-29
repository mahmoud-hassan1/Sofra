import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sofra/core/utils/assets.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondaryColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.all(16),
        child: SvgPicture.asset(Assets.profileIcon),
      ),
      actions: [
        Text(
          'YOUR PROFILE',
          style: AppFonts.header.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
            color: AppColors.neutralColor,
          ),
        ),
        const SizedBox(width: 20),
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(3),
        child: Divider(height: 3, thickness: 3, color: AppColors.neutralColor),
      ),
    );
  }
}
