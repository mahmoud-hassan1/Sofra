import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/core/services/service_locator.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/core/widgets/custom_app_bar.dart';
import 'package:sofra/features/favorite%20recipe/presentation/cubit/favorite_recipes_cubit.dart';
import 'package:sofra/features/favorite%20recipe/widgets/custom_favorite_card.dart';
import 'package:sofra/features/favorite%20recipe/widgets/header_text.dart';
import 'package:sofra/features/favorite%20recipe/widgets/secondary_text.dart';
import 'package:sofra/core/widgets/neo_button.dart';
import 'package:sofra/features/recipe%20details/recipe_details.dart';

class FavoriteRecipeBody extends StatelessWidget {
  const FavoriteRecipeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FavoriteRecipesCubit>()..loadSavedRecipes(),
      child: Scaffold(
        backgroundColor: AppColors.secondaryColor[50],
        appBar: CustomAppBar(
          leadingWidth: 200.0,
          appBarHeight: 77.0,
          backgroundColor: AppColors.brownAppBarBackground,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Text(
              "Sofra",
              style: AppFonts.header.copyWith(color: AppColors.backGroundColor),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Icon(
                Icons.search,
                size: 28,
                color: AppColors.backGroundColor,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 24.0,
              ),
              child: Column(
                children: [
                  HeaderText(),
                  SizedBox(height: 7.5),
                  SecondaryText(),
                  SizedBox(height: 16),
                  BlocBuilder<FavoriteRecipesCubit, FavoriteRecipesState>(
                    builder: (context, state) {
                      if (state.status == FavoriteRecipesStatus.loading || state.status == FavoriteRecipesStatus.initial) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32.0),
                            child: CircularProgressIndicator(color: AppColors.primaryColor),
                          ),
                        );
                      } else if (state.status == FavoriteRecipesStatus.failure) {
                        return Center(
                          child: Column(
                            children: [
                              Text(
                                state.errorMessage ?? "Failed to load favorites",
                                style: TextStyle(color: AppColors.errorColor),
                              ),
                              const SizedBox(height: 16),
                              NeoButton(
                                text: 'Try Again',
                                onTap: () => context.read<FavoriteRecipesCubit>().loadSavedRecipes(),
                              )
                            ],
                          ),
                        );
                      } else if (state.recipes.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Text(
                              "No favorite recipes found.",
                              style: AppFonts.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      }

                      return ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final recipe = state.recipes[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecipeDetails(recipeId: recipe.id),
                                ),
                              );
                            },
                            child: CustomFavoriteCard(recipe: recipe),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(height: 27),
                        itemCount: state.recipes.length,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
