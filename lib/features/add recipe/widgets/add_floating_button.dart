import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';

class AddFloatingButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;

  const AddFloatingButton({
    super.key,
    required this.onTap,
    this.icon = Icons.add,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.neutralColor, width: 2),
          boxShadow: const [
            BoxShadow(
              color: AppColors.neutralColor,
              offset: Offset(3, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: Icon(icon, color: Colors.black, size: 28),
      ),
    );
  }
}