import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';

class AddRecipeBody extends StatelessWidget {
  const AddRecipeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor[50],
      body: SafeArea(
        child: Center(
          child: Text(
            "Recipe Screen",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ),
    );
  }
}
