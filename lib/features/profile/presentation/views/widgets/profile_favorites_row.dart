import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/features/favorite%20recipe/presentation/cubit/favorite_recipes_cubit.dart';
import 'package:sofra/features/profile/presentation/views/widgets/favorite_card.dart';

class ProfileFavoritesRow extends StatelessWidget {
  const ProfileFavoritesRow({super.key});

  @override
  Widget build(BuildContext context) {
    // FavoriteRecipesCubit is provided by HomeLayout (shared with the
    // Favorites tab). The HomeLayout listener reloads it when the user
    // switches to the Profile tab, so this strip always shows fresh data.
    return const _FavoritesContent();
  }
}

class _FavoritesContent extends StatelessWidget {
  const _FavoritesContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteRecipesCubit, FavoriteRecipesState>(
      builder: (context, state) {
        if (state.status == FavoriteRecipesStatus.initial ||
            state.status == FavoriteRecipesStatus.loading) {
          return const SizedBox(
            height: 160,
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            ),
          );
        }

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

        return SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: state.recipes.length,
            separatorBuilder: (context, index) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final recipe = state.recipes[index];
              return FavoriteCard(recipe: recipe);
            },
          ),
        );
      },
    );
  }
}
