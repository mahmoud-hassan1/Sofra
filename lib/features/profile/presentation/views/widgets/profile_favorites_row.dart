import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/core/services/service_locator.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/features/favorite%20recipe/presentation/cubit/favorite_recipes_cubit.dart';
import 'package:sofra/features/home/domain/entities/recipe_entity.dart';
import 'package:sofra/features/recipe%20details/recipe_details.dart';

/// Self-contained favorites row for the Profile screen.
/// Owns its own [FavoriteRecipesCubit] so its loading state is
/// completely independent from the profile data above.
class ProfileFavoritesRow extends StatelessWidget {
  const ProfileFavoritesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FavoriteRecipesCubit>()..loadSavedRecipes(),
      child: const _FavoritesContent(),
    );
  }
}

class _FavoritesContent extends StatelessWidget {
  const _FavoritesContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteRecipesCubit, FavoriteRecipesState>(
      builder: (context, state) {
        // ── Loading ──────────────────────────────────────────────────────
        if (state.status == FavoriteRecipesStatus.initial ||
            state.status == FavoriteRecipesStatus.loading) {
          return const SizedBox(
            height: 160,
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            ),
          );
        }

        // ── Error ────────────────────────────────────────────────────────
        if (state.status == FavoriteRecipesStatus.failure) {
          return SizedBox(
            height: 100,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.errorMessage ?? 'Failed to load favorites',
                    style: AppFonts.bodyMedium.copyWith(
                      color: AppColors.errorColor,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () =>
                        context.read<FavoriteRecipesCubit>().loadSavedRecipes(),
                    child: Text(
                      'Retry',
                      style: AppFonts.label.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryColor,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // ── Empty ────────────────────────────────────────────────────────
        if (state.recipes.isEmpty) {
          return Container(
            height: 100,
            alignment: Alignment.center,
            child: Text(
              'No saved recipes yet.',
              style: AppFonts.bodyMedium.copyWith(
                color: AppColors.seconderyFontColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }

        // ── Success ──────────────────────────────────────────────────────
        return SizedBox(
          height: 175,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: state.recipes.length,
            separatorBuilder: (context, index) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final recipe = state.recipes[index];
              return _FavoriteCard(recipe: recipe);
            },
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Compact horizontal card for each saved recipe
// ---------------------------------------------------------------------------
class _FavoriteCard extends StatelessWidget {
  final RecipeEntity recipe;
  const _FavoriteCard({required this.recipe});

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
            // Recipe image
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
            // Title + meta
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      style: AppFonts.bodyMedium.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                        const Icon(Icons.favorite, size: 12, color: Colors.red),
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
