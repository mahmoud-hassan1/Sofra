import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/core/widgets/custom_app_bar.dart';
import 'package:sofra/features/favorite%20recipe/widgets/custom_favorite_card.dart';
import 'package:sofra/features/favorite%20recipe/widgets/header_text.dart';
import 'package:sofra/features/favorite%20recipe/widgets/secondary_text.dart';

class FavoriteRecipeBody extends StatelessWidget {
  const FavoriteRecipeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => CustomFavoriteCard(),
                  separatorBuilder: (context, index) => SizedBox(height: 27),
                  itemCount: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
