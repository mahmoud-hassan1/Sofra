import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/core/widgets/custom_text_form_field.dart';
import 'package:sofra/core/widgets/custom_textarea.dart';
import 'package:sofra/features/add%20recipe/cubit/add_recipe_cubit.dart';
import 'package:sofra/features/add%20recipe/widgets/decorated_container.dart';

class AddRecipeName extends StatelessWidget {
  const AddRecipeName({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddRecipeCubit>();
    return DecoratedContainer(
      backgroundColor: AppColors.lightbrownContainerBackgroundColor,
      width: 354,
      height: 242,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormField(
            controller: cubit.nameController,
            label: "RECIPE NAME",
            hintText: "e.g: Pepperoni Pizza",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: 12.0),
          Text("DESCRIPTION", style: AppFonts.label),
          const SizedBox(height: 6.0),
          CustomTextArea(
            controller: cubit.descriptionController,
            maxLines: 3,
            minLines: 2,
            hintText: "Tell us about your recipe",
          ),
        ],
      ),
    );
  }
}
