import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/core/widgets/custom_app_bar.dart';
import 'package:sofra/features/add%20recipe/widgets/add_category.dart';
import 'package:sofra/features/add%20recipe/widgets/add_recipe_name.dart';
import 'package:sofra/features/add%20recipe/widgets/add_photo.dart';
import 'package:sofra/features/add%20recipe/widgets/recipe_description.dart';

class AddRecipeBody extends StatelessWidget {
  const AddRecipeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Column(
              children: [
                Addphoto(),
                SizedBox(height: 20),
                AddRecipeName(),
                SizedBox(height: 20),
                AddCategory(),
                SizedBox(height: 20),
                RecipeDescription(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(354, 58),
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Text(
                    "POST RECIPE",
                    style: AppFonts.header.copyWith(
                      color: AppColors.backGroundColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
