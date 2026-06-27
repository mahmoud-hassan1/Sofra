import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';

class FavoriteRecipeBody extends StatelessWidget {
  const FavoriteRecipeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor[50],
      body: SafeArea(child: Center(child: Text("Favorite Recipes"))),
    );
  }
}
