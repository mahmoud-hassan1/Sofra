import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/core/services/service_locator.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/widgets/custom_bottom_bar.dart';
import 'package:sofra/features/add%20recipe/add_recipe.dart';
import 'package:sofra/features/favorite%20recipe/favorite_recipe.dart';
import 'package:sofra/features/favorite%20recipe/presentation/cubit/favorite_recipes_cubit.dart';
import 'package:sofra/features/home/cubit/home_navigation_cubit.dart';
import 'package:sofra/features/home/home_screen.dart';
import 'package:sofra/features/posts/posts_screen.dart';
import 'package:sofra/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:sofra/features/profile/presentation/controllers/cubit/profile_cubit.dart';
import 'package:sofra/features/profile/presentation/views/profile_screen.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // All tab-level cubits are hoisted here so the BlocConsumer listener
        // below can reload them on tab switch — keeping data fresh without
        // requiring a hot restart.
        BlocProvider(
          create: (_) => sl<FavoriteRecipesCubit>()..loadSavedRecipes(),
        ),
        BlocProvider(
          create: (_) => sl<PostsCubit>()..loadMyRecipes(),
        ),
        BlocProvider(
          create: (_) => sl<ProfileCubit>()..getProfile(),
        ),
      ],
      child: BlocConsumer<HomeNavigationCubit, HomeNavigationState>(
        listener: (context, state) {
          switch (state.currentIndex) {
            case 2:
              // Favorites tab — reload saved recipes
              context.read<FavoriteRecipesCubit>().loadSavedRecipes();
            case 3:
              // My Posts tab — reload user's recipes
              context.read<PostsCubit>().loadMyRecipes();
            case 4:
              // Profile tab — reload profile data and the favorites strip
              context.read<ProfileCubit>().getProfile();
              context.read<FavoriteRecipesCubit>().loadSavedRecipes();
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.tertiaryColor[500],
            body: IndexedStack(
              index: state.currentIndex,
              children: const [
                HomeScreenBody(),
                AddRecipeBody(),
                FavoriteRecipeBody(),
                PostsScreenBody(),
                ProfileScreenBody(),
              ],
            ),
            bottomNavigationBar: CustomBottomBar(
              currentIndex: state.currentIndex,
              onTap: (index) {
                context.read<HomeNavigationCubit>().changeIndex(index);
              },
            ),
          );
        },
      ),
    );
  }
}
