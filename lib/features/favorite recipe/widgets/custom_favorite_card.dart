import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/core/widgets/custom_card.dart';
import 'package:sofra/core/widgets/custom_tag_row.dart';
import 'package:sofra/features/favorite%20recipe/widgets/recipe_image.dart';
import 'package:sofra/features/home/domain/entities/recipe_entity.dart';

class CustomFavoriteCard extends StatelessWidget {
  final RecipeEntity recipe;

  const CustomFavoriteCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      width: 355,
      bgColor: AppColors.primaryColor.shade100,
      containerBody: Column(
        children: [
          RecipeImage(imageUrl: recipe.imageUrl),
          SizedBox(height: 16),
          Align(
            alignment: AlignmentGeometry.centerLeft,
            child: Text(
              recipe.title,
              style: AppFonts.header.copyWith(
                color: AppColors.seconderyFontColor[500],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              CustomTagRow(
                label: recipe.category.isNotEmpty ? recipe.category : "Dinner",
                color: AppColors.backGroundSecondColor,
              ),
              SizedBox(width: 16),
              CustomTagRow(
                label: recipe.deliveryTime,
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
                recipe.likeCount > 1000
                    ? " ${(recipe.likeCount / 1000).toStringAsFixed(1)}k Likes"
                    : " ${recipe.likeCount} Likes",
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
