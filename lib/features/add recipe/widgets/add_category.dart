import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/widgets/custom_text_form_field.dart';
import 'package:sofra/features/add%20recipe/widgets/decorated_container.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final category = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      width: 354,
      height: 400,
      backgroundColor: AppColors.categoryBackgroundContainerAddRecipePage,
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: [
          CustomTextFormField(
            label: "CATEGORY ",
            hintText: "e.g: Pizza",
            controller: category,
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
            label: "Youtube URL (Optional)",
            hintText: "e.g: https://www.youtube.com/...",
          ),
        ],
      ),
    );
  }
}
