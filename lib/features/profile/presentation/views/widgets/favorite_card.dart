import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/core/utils/assets.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/core/widgets/neo_toggle_button.dart';
import 'package:sofra/features/favorite%20recipe/presentation/cubit/favorite_recipes_cubit.dart';
import 'package:sofra/features/home/domain/entities/recipe_entity.dart';
import 'package:sofra/features/recipe%20details/recipe_details.dart';

class FavoriteCard extends StatelessWidget {
  final RecipeEntity recipe;
  const FavoriteCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => RecipeDetails(recipeId: recipe.id)),
      ),
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.neutralColor, width: 2),
          boxShadow: const [
            BoxShadow(
              color: AppColors.neutralColor,
              offset: Offset(4, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: recipe.imageUrl.isNotEmpty
                  ? Image.network(
                      recipe.imageUrl,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) =>
                          _imagePlaceholder(),
                    )
                  : _imagePlaceholder(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 32, // Forces exactly 2 lines of space
                      child: Text(
                        recipe.title,
                        style: AppFonts.bodyMedium.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          size: 12,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          recipe.deliveryTime,
                          style: AppFonts.bodyMedium.copyWith(
                            fontSize: 11,
                            color: AppColors.seconderyFontColor,
                          ),
                        ),
                        const Spacer(),
                        Transform.scale(
                          scale: 0.75,
                          child: NeoToggleButton(
                            svgPath: Assets.favouriteIcon,
                            isActive: true,
                            activeBgColor: AppColors.backGroundSecondColor,
                            inactiveBgColor: AppColors.primaryColor[500]!,
                            activeIconColor: AppColors.primaryColor[500]!,
                            inactiveIconColor: AppColors.backGroundSecondColor,
                            onTap: () {
                              context
                                  .read<FavoriteRecipesCubit>()
                                  .toggleFavorite(recipe.id);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imagePlaceholder() => Container(
    height: 100,
    width: double.infinity,
    color: AppColors.primaryColor.shade50,
    child: const Icon(
      Icons.restaurant_rounded,
      size: 36,
      color: AppColors.primaryColor,
    ),
  );
}
