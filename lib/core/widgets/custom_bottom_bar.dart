import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/widgets/custom_card.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

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
            _bottomBarItem(
              icon: Icons.home_rounded,
              text: "Home",
              isActive: true,
            ),
            _bottomBarItem(icon: Icons.add, text: "Add", isActive: false),
            _bottomBarItem(
              icon: Icons.favorite_border,
              text: "Saved",
              isActive: false,
            ),
            _bottomBarItem(
              icon: Icons.check_box_outlined,
              text: "Posts",
              isActive: false,
            ),
            _bottomBarItem(
              icon: Icons.person_outline,
              text: "Profile",
              isActive: false,
            ),
          ],
        ),
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

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.neutralColor, size: 22),
          const SizedBox(height: 2),
          Text(
            text,
            style: const TextStyle(color: AppColors.neutralColor, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
