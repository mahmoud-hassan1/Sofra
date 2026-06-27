import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/core/widgets/custom_card.dart';
import 'package:sofra/core/widgets/custom_tag_row.dart';
import 'package:sofra/features/favorite%20recipe/widgets/recipe_image.dart';

class CustomFavoriteCard extends StatelessWidget {
  const CustomFavoriteCard({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return CustomCard(
      height: height * .536,
      width: width * .9,
      bgColor: AppColors.primaryColor.shade100,
      containerBody: Column(
        children: [
          RecipeImage(height: height, width: width),
          SizedBox(height: 16),
          Align(
            alignment: AlignmentGeometry.centerLeft,
            child: Text(
              "Monster\nSmashburger",
              style: AppFonts.header.copyWith(
                color: AppColors.seconderyFontColor[500],
              ),
            ),
          ),
          Row(
            children: [
              CustomTagRow(
                label: "Dinner",
                color: AppColors.backGroundSecondColor,
              ),
              SizedBox(width: 16),
              CustomTagRow(
                label: "25m",
                color: AppColors.backGroundSecondColor,
                icon: Icon(Icons.timer_sharp),
              ),
            ],
          ),
          SizedBox(height: 8),
          Divider(color: AppColors.seconderyFontColor),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.favorite, color: Colors.red),
              Text(
                "12.4k Likes",
                style: AppFonts.bodyMedium.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Space Grotesk",
                  color: AppColors.seconderyFontColor[500],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


