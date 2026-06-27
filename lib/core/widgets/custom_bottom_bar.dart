import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/widgets/custom_card.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.primaryColor)),
        color: AppColors.backGroundSecondColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildBottomBarItemButton(
              index: 0,
              icon: Icons.home_rounded,
              text: "Home",
              isActive: currentIndex == 0,
              onTap: onTap,
            ),
            _buildBottomBarItemButton(
              index: 1,
              icon: Icons.add,
              text: "Add",
              isActive: currentIndex == 1,
              onTap: onTap,
            ),
            _buildBottomBarItemButton(
              index: 2,
              icon: Icons.favorite_border,
              text: "Saved",
              isActive: currentIndex == 2,
              onTap: onTap,
            ),
            _buildBottomBarItemButton(
              index: 3,
              icon: Icons.check_box_outlined,
              text: "Posts",
              isActive: currentIndex == 3,
              onTap: onTap,
            ),
            _buildBottomBarItemButton(
              index: 4,
              icon: Icons.person_outline,
              text: "Profile",
              isActive: currentIndex == 4,
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBarItemButton({
    required int index,
    required IconData icon,
    required String text,
    required bool isActive,
    required Function(int) onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: _bottomBarItem(icon: icon, text: text, isActive: isActive),
      ),
    );
  }

  Widget _bottomBarItem({
    required IconData icon,
    required String text,
    required bool isActive,
  }) {
    if (isActive) {
      return CustomCard(
        height: 100,
        shadow: 3,
        width: 70,
        leftBorder: false,
        topBorder: false,
        bigBodrer: 3,
        bgColor: AppColors.primaryColor,
        containerBody: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 22),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: AppColors.neutralColor, size: 22),
        const SizedBox(height: 2),
        Text(
          text,
          style: const TextStyle(color: AppColors.neutralColor, fontSize: 11),
        ),
      ],
    );
  }
}
