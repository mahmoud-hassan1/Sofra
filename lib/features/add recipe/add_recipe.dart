import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/core/services/service_locator.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/core/widgets/custom_app_bar.dart';
import 'package:sofra/features/add%20recipe/cubit/add_recipe_cubit.dart';
import 'package:sofra/features/add%20recipe/cubit/add_recipe_state.dart';
import 'package:sofra/features/add%20recipe/widgets/add_category.dart';
import 'package:sofra/features/add%20recipe/widgets/add_recipe_name.dart';
import 'package:sofra/features/add%20recipe/widgets/add_photo.dart';
import 'package:sofra/features/add%20recipe/widgets/recipe_description.dart';

class AddRecipeBody extends StatelessWidget {
  const AddRecipeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AddRecipeCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.lightScaffoldAddRecipeBackgroundColor,
        appBar: CustomAppBar(
          leadingWidth: 400.0,
          appBarHeight: 72.0,
          backgroundColor: AppColors.lightBrownAppBarBackground,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Text(
              "DROP A RECIPE",
              style: AppFonts.header.copyWith(
                color: AppColors.darkAppBarTextColor,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                backgroundColor: AppColors.greenAvatarBackgroundColor,
                radius: 24.0,
                child: Image.asset(
                  "assets/icons/foodutil.png",
                  width: 18,
                  height: 18,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: BlocConsumer<AddRecipeCubit, AddRecipeState>(
                listener: (context, state) {
                  if (state is AddRecipeSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Recipe added successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (state is AddRecipeError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: AppColors.errorColor,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      const Addphoto(),
                      const SizedBox(height: 20),
                      const AddRecipeName(),
                      const SizedBox(height: 20),
                      const AddCategory(),
                      const SizedBox(height: 20),
                      const RecipeDescription(),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: state is AddRecipeLoading
                            ? null
                            : () {
                                context.read<AddRecipeCubit>().submitRecipe();
                              },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(354, 58),
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: state is AddRecipeLoading
                            ? const CircularProgressIndicator(color: AppColors.backGroundColor)
                            : Text(
                                "POST RECIPE",
                                style: AppFonts.header.copyWith(
                                  color: AppColors.backGroundColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
