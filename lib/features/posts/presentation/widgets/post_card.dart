import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/features/home/domain/entities/recipe_entity.dart';
import 'package:sofra/features/posts/presentation/widgets/post_image.dart';
import 'package:sofra/features/posts/presentation/widgets/post_tag.dart';
import 'package:sofra/features/recipe%20details/recipe_details.dart';

class PostCard extends StatelessWidget {
  final RecipeEntity recipe;
  const PostCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => RecipeDetails(recipeId: recipe.id)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.neutralColor, width: 2),
          boxShadow: const [
            BoxShadow(
              color: AppColors.neutralColor,
              offset: Offset(5, 5),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(12),
              ),
              child: PostImage(imageUrl: recipe.imageUrl),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      style: AppFonts.header.copyWith(fontSize: 17),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        if (recipe.category.isNotEmpty)
                          PostTag(label: recipe.category),
                        PostTag(
                          label: recipe.deliveryTime,
                          icon: Icons.timer_outlined,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.favorite, color: Colors.red, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          recipe.likeCount > 1000
                              ? '${(recipe.likeCount / 1000).toStringAsFixed(1)}k Likes'
                              : '${recipe.likeCount} Likes',
                          style: AppFonts.bodyMedium.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.seconderyFontColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 12),
            //   child: Container(
            //     width: 34,
            //     height: 34,
            //     decoration: BoxDecoration(
            //       color: AppColors.secondaryColor,
            //       borderRadius: BorderRadius.circular(8),
            //       border: Border.all(color: AppColors.neutralColor, width: 1.5),
            //       boxShadow: const [
            //         BoxShadow(
            //           color: AppColors.neutralColor,
            //           offset: Offset(2, 2),
            //           blurRadius: 0,
            //         ),
            //       ],
            //     ),
            //     child: const Icon(Icons.edit_outlined, size: 17),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
