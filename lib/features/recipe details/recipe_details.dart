import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/core/services/service_locator.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/core/widgets/custom_app_bar.dart';
import 'package:sofra/core/widgets/neo_button.dart';
import 'package:sofra/features/recipe%20details/presentation/cubit/recipe_details_cubit.dart';
import 'package:sofra/features/recipe%20details/widgets/image_container.dart';
import 'package:sofra/features/recipe%20details/widgets/ingredients_card.dart';
import 'package:sofra/features/recipe%20details/widgets/recipe_headers.dart';
import 'package:sofra/features/recipe%20details/widgets/steps_card.dart';
import 'package:sofra/features/recipe%20details/widgets/watch_youtube.dart';
import 'package:sofra/features/recipe%20details/widgets/youtube_container.dart';
import 'package:sofra/core/widgets/custom_bottom_bar.dart';
import 'package:sofra/features/home/cubit/home_navigation_cubit.dart';

class RecipeDetails extends StatelessWidget {
  final String recipeId;
  final VoidCallback? onBack;

  const RecipeDetails({
    super.key,
    required this.recipeId,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RecipeDetailsCubit>()..loadRecipeDetails(recipeId),
      child: Scaffold(
        backgroundColor: AppColors.lightBrownAppBarBackground,
        appBar: CustomAppBar(
          leading: InkWell(
            onTap: onBack ?? () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          backgroundColor: AppColors.brownAppBarBackground,
          leadingWidth: 100,
          appBarHeight: 64,
          titleHeader: Text(
            "MunchieDash",
            style: AppFonts.header.copyWith(
              color: AppColors.backGroundSecondColor,
            ),
          ),
        ),
        bottomNavigationBar: BlocBuilder<HomeNavigationCubit, HomeNavigationState>(
          builder: (context, state) {
            return CustomBottomBar(
              currentIndex: state.currentIndex,
              onTap: (index) {
                context.read<HomeNavigationCubit>().changeIndex(index);
                Navigator.pop(context);
              },
            );
          },
        ),
        body: SafeArea(
          child: BlocBuilder<RecipeDetailsCubit, RecipeDetailsState>(
            builder: (context, state) {
              if (state.status == RecipeDetailsStatus.loading || state.status == RecipeDetailsStatus.initial) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              } else if (state.status == RecipeDetailsStatus.failure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.errorMessage ?? 'Failed to load recipe details',
                        style: AppFonts.bodyMedium.copyWith(color: AppColors.errorColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      NeoButton(
                        text: 'Try Again',
                        onTap: () {
                          context.read<RecipeDetailsCubit>().loadRecipeDetails(recipeId);
                        },
                      ),
                    ],
                  ),
                );
              }

              final recipe = state.recipe!;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      ImageContiner(
                        imageUrl: recipe.imageUrl,
                        region: recipe.region,
                        likeCount: recipe.likeCount,
                      ),
                      const SizedBox(height: 16),
                      RecipeHeaders(
                        title: recipe.title,
                        cookingTimeMinutes: recipe.cookingTimeMinutes,
                        kitchenType: recipe.kitchenType,
                      ),
                      const SizedBox(height: 16),
                      YoutubeContainer(youtubeUrl: recipe.youtubeUrl),
                      if (recipe.youtubeUrl != null && recipe.youtubeUrl!.isNotEmpty)
                        const SizedBox(height: 16),
                      WatchYoutube(youtubeUrl: recipe.youtubeUrl),
                      if (recipe.youtubeUrl != null && recipe.youtubeUrl!.isNotEmpty)
                        const SizedBox(height: 16),
                      IngredientsCard(ingredients: recipe.ingredients),
                      const SizedBox(height: 16),
                      StepsCard(steps: recipe.steps),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
