import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/widgets/custom_text_form_field.dart';
import 'package:sofra/features/add%20recipe/cubit/add_recipe_cubit.dart';
import 'package:sofra/features/add%20recipe/widgets/decorated_container.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddRecipeCubit>();
    return DecoratedContainer(
      width: 354,
      backgroundColor: AppColors.categoryBackgroundContainerAddRecipePage,
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: [
          CustomTextFormField(
            label: "CATEGORY",
            hintText: "e.g: Pizza",
            controller: cubit.categoryController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: 12.0),
          CustomTextFormField(
            label: "KITCHEN TYPE",
            hintText: "e.g: Air Fryer,Oven,Stove",
            controller: cubit.kitchenTypeController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: 12.0),
          CustomTextFormField(
            label: "Cooking Time",
            hintText: "e.g: enter time in minutes",
            controller: cubit.cookingTimeController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              } else if (int.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          const SizedBox(height: 12.0),
          CustomTextFormField(
            label: "REGION",
            hintText: "e.g: Middle East",
            controller: cubit.regionController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: 12.0),
          CustomTextFormField(
            label: "Youtube URL (Optional)",
            hintText: "e.g: https://www.youtube.com/...",
            controller: cubit.youtubeUrlController,
          ),
        ],
      ),
    );
  }
}
