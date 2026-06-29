import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/core/widgets/custom_text_form_field.dart';
import 'package:sofra/core/widgets/custom_textarea.dart';
import 'package:sofra/features/add%20recipe/widgets/add_floating_button.dart';
import 'package:sofra/features/add%20recipe/widgets/decorated_container.dart';

class RecipeDescription extends StatefulWidget {
  const RecipeDescription({super.key});

  @override
  _RecipeDescriptionState createState() => _RecipeDescriptionState();
}

class _RecipeDescriptionState extends State<RecipeDescription> {
  final List<TextEditingController> stepControllers = [
    TextEditingController(text: "Open bag."),
    TextEditingController(),
  ];
  void _addNewStepField() {
    setState(() {
      stepControllers.add(TextEditingController());
    });
  }

  void _saveDataToDatabase() {
    List<String> stepsToSave = stepControllers
        .map((controller) => controller.text.trim())
        .where((text) => text.isNotEmpty) // Filter out accidental empty entries
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final ingredients = TextEditingController();
    return DecoratedContainer(
      width: 354,
      backgroundColor: AppColors.secondaryColor[200]!,
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                Image.asset(
                  "assets/icons/ingredient.png",
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Ingredients',
                  style: AppFonts.header.copyWith(
                    color: AppColors.primaryFontColor,
                  ),
                ),
              ],
            ),
            Text(
              "One per line, keep it simple",
              style: AppFonts.label.copyWith(fontWeight: FontWeight.normal),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 16),
            CustomTextArea(
              hintText: "e.g: 1/2 cup of flour",
              controller: ingredients,
              maxLines: 4,
              minLines: 3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: const Divider(color: AppColors.seconderyFontColor),
            ),
            Row(
              children: [
                const Icon(
                  Icons.list_alt_rounded,
                  color: AppColors.primaryFontColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Instructions',
                  style: AppFonts.header.copyWith(
                    color: AppColors.primaryFontColor,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: AddFloatingButton(onTap: _addNewStepField),
            ),
            const SizedBox(height: 8),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: stepControllers.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return CustomTextFormField(
                  controller: stepControllers[index],
                  hintText: '${index + 1}. Type step instructions...',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
