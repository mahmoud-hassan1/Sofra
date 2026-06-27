import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sofra/core/utils/colors.dart';

class NeoToggleButton extends StatelessWidget {
  const NeoToggleButton({
    super.key,
    required this.svgPath,
    required this.isActive,
    required this.onTap,
    required this.activeBgColor,
    required this.inactiveBgColor,
    required this.activeIconColor,
    required this.inactiveIconColor,
  });

  final String svgPath;
  final bool isActive;
  final VoidCallback onTap;
  final Color activeBgColor;
  final Color inactiveBgColor;
  final Color activeIconColor;
  final Color inactiveIconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isActive ? activeBgColor : inactiveBgColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.neutralColor,
            width: 2.5,
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.neutralColor,
              offset: Offset(2, 2),
              spreadRadius: 0,
              blurRadius: 0,
            ),
          ],
        ),
        child: SvgPicture.asset(
          svgPath,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            isActive ? activeIconColor : inactiveIconColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}