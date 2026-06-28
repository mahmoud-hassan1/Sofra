import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/core/widgets/custom_app_bar.dart';

class AddRecipeBody extends StatelessWidget {
  const AddRecipeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor[50],
      appBar: CustomAppBar(
        leadingWidth: 220.0,
        appBarHeight: 72.0,
        backgroundColor: AppColors.lightBrownAppBarBackground,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Text(
            "Drop A Recipe",
            style: AppFonts.header.copyWith(
              color: AppColors.darkAppBarTextColor,
            ),
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: AppColors.greenAvatarBackgroundColor,
            radius: 48,
            child: Image.asset(
              "assets/icons/foodutil.png",
              width: 18,
              height: 18,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  width: 354,
                  height: 224,
                  decoration: BoxDecoration(
                    color: AppColors.backGroundColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.neutralColor,
                      width: 2.5,
                    ),
                  ),
                  child:Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
