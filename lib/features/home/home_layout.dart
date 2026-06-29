import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/widgets/custom_bottom_bar.dart';
import 'package:sofra/features/add%20recipe/add_recipe.dart';
import 'package:sofra/features/favorite%20recipe/favorite_recipe.dart';
import 'package:sofra/features/home/cubit/home_navigation_cubit.dart';
import 'package:sofra/features/home/home_screen.dart';
import 'package:sofra/features/posts/posts_screen.dart';
import 'package:sofra/features/profile/presentation/views/profile_screen.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeNavigationCubit, HomeNavigationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.tertiaryColor[500],
          body: _buildBody(state.currentIndex),
          bottomNavigationBar: CustomBottomBar(
            currentIndex: state.currentIndex,
            onTap: (index) {
              context.read<HomeNavigationCubit>().changeIndex(index);
            },
          ),
        );
      },
    );
  }

  Widget _buildBody(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const HomeScreenBody();
      case 1:
        return const AddRecipeBody();
      case 2:
        return const FavoriteRecipeBody();
      case 3:
        return const PostsScreenBody();
      case 4:
        return const ProfileScreenBody();
      default:
        return const HomeScreenBody();
    }
  }
}
