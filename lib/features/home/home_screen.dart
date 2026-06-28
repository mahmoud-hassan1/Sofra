import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/core/network/api_service.dart';
import 'package:sofra/core/services/service_locator.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/core/widgets/neo_button.dart';
import 'package:sofra/features/home/data/repositories/recipe_repository_impl.dart';
import 'package:sofra/features/home/domain/usecases/get_recipes_usecase.dart';
import 'package:sofra/features/home/domain/usecases/toggle_save_recipe_usecase.dart';
import 'package:sofra/features/home/cubit/home_body_cubit.dart';
import 'package:sofra/features/home/widget/filter_row.dart';
import 'package:sofra/features/home/widget/home_card.dart';
import 'package:sofra/features/home/widget/popular_item_card.dart';
import 'package:sofra/features/home/widget/search_input.dart';
import 'package:sofra/features/recipe%20details/recipe_details.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final apiService = sl<ApiService>();
        final repository = RecipeRepositoryImpl(apiService: apiService);
        final getRecipesUseCase = GetRecipesUseCase(repository);
        final toggleSaveRecipeUseCase = ToggleSaveRecipeUseCase(repository);
        return HomeBodyCubit(
          getRecipesUseCase: getRecipesUseCase,
          toggleSaveRecipeUseCase: toggleSaveRecipeUseCase,
        )..loadRecipes();
      },
      child: const HomeScreenBodyContent(),
    );
  }
}

class HomeScreenBodyContent extends StatelessWidget {
  const HomeScreenBodyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: BlocBuilder<HomeBodyCubit, HomeBodyState>(
          builder: (context, state) {
            return CustomScrollView(
              clipBehavior: Clip.none,
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SearchInput(),
                      const SizedBox(height: 32),
                      const PopularItemCard(),
                      const SizedBox(height: 32),
                      const FilterRow(),
                      const SizedBox(height: 32),
                      Text("Nearby Craves", style: AppFonts.header),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
                if (state.status == HomeBodyStatus.loading)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor[500],
                      ),
                    ),
                  )
                else if (state.status == HomeBodyStatus.failure)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/Empty.png',
                            height: 220,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              'Failed to load recipes: TRY AGAIN ',
                              style: AppFonts.bodyMedium.copyWith(
                                color: AppColors.errorColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 24),
                          NeoButton(
                            text: 'Try Again',
                            onTap: () {
                              context.read<HomeBodyCubit>().loadRecipes();
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                else if (state.recipes.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/Empty.png',
                            height: 220,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No recipes found.',
                            style: AppFonts.bodyMedium.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 24),
                          NeoButton(
                            text: 'Clear Filters & Search',
                            onTap: () {
                              context.read<HomeBodyCubit>().clearFilters();
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SliverList.builder(
                    itemCount: state.recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = state.recipes[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: InkWell(
                          onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecipeDetails(recipeId: recipe.id),
                                ),
                              );
                          },
                          child: HomeCard(
                            bgColor: recipe.bgColor,
                            title: recipe.title,
                            isSaved: recipe.isSaved,
                            likesCount: recipe.likeCount,
                            category: recipe.category,
                            deliveryTime: recipe.deliveryTime,
                            tags: recipe.tags,
                            imagePath: recipe.imageUrl,
                            onFavoriteTap: () {
                              context.read<HomeBodyCubit>().toggleSaveRecipe(
                                recipe.id,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
