import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backGroundColor,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.neutralColor, width: 1),
        boxShadow: const [
          BoxShadow(
            color: AppColors.neutralColor,
            offset: Offset(4, 6),
            blurRadius: 0,
          ),
        ],
      ),
      child: const TextField(
        style: TextStyle(
          color: AppColors.neutralColor,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'Search for munchies...',
          hintStyle: TextStyle(
            color: AppColors.neutralColor,
            fontWeight: FontWeight.w500,
          ),
          suffixIcon: Icon(Icons.search, color: AppColors.neutralColor, size: 26),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        ),
      ),
    );
  }
}