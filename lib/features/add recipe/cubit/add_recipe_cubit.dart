import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/features/home/domain/usecases/create_recipe_usecase.dart';
import 'package:sofra/features/add%20recipe/cubit/add_recipe_state.dart';

class AddRecipeCubit extends Cubit<AddRecipeState> {
  final CreateRecipeUseCase createRecipeUseCase;

  AddRecipeCubit(this.createRecipeUseCase) : super(AddRecipeInitial());

  File? selectedImage;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController kitchenTypeController = TextEditingController();
  final TextEditingController cookingTimeController = TextEditingController();
  final TextEditingController youtubeUrlController = TextEditingController();
  final TextEditingController regionController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final List<TextEditingController> stepControllers = [
    TextEditingController(text: "Open bag."),
    TextEditingController(),
  ];

  void setSelectedImage(File? image) {
    selectedImage = image;
  }

  void addStepField() {
    stepControllers.add(TextEditingController());
    // Emit state to rebuild the UI if necessary, though the UI could just use setState for the steps list
    emit(AddRecipeInitial());
  }

  Future<void> submitRecipe() async {
    if (nameController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty ||
        categoryController.text.trim().isEmpty ||
        kitchenTypeController.text.trim().isEmpty ||
        cookingTimeController.text.trim().isEmpty ||
        regionController.text.trim().isEmpty ||
        ingredientsController.text.trim().isEmpty) {
      emit(AddRecipeError('Please fill in all required fields.'));
      return;
    }

    final int? cookingTime = int.tryParse(cookingTimeController.text.trim());
    if (cookingTime == null || cookingTime < 1 || cookingTime > 1440) {
      emit(AddRecipeError('Cooking time must be a number between 1 and 1440.'));
      return;
    }

    // Parse ingredients — each line: "quantity name" e.g. "1/2 cup flour"
    final List<Map<String, String>> ingredients = [];
    for (final line in ingredientsController.text.split('\n')) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) continue;
      final parts = trimmed.split(' ');
      final quantity = parts.first;
      final name = parts.skip(1).join(' ');
      ingredients.add({
        'quantity': name.isNotEmpty ? quantity : '1',
        'name': name.isNotEmpty ? name : trimmed,
      });
    }

    if (ingredients.isEmpty) {
      emit(AddRecipeError('Please add at least one ingredient.'));
      return;
    }

    // Parse steps — skip empty controllers
    final List<Map<String, dynamic>> steps = [];
    for (int i = 0; i < stepControllers.length; i++) {
      final text = stepControllers[i].text.trim();
      if (text.isNotEmpty) {
        steps.add({'order': i + 1, 'text': text});
      }
    }

    if (steps.isEmpty) {
      emit(AddRecipeError('Please add at least one step.'));
      return;
    }

    emit(AddRecipeLoading());

    try {
      final Map<String, dynamic> data = {
        'name': nameController.text.trim(),
        'description': descriptionController.text.trim(),
        'category': categoryController.text.trim(),
        'kitchenType': kitchenTypeController.text.trim(),
        'cookingTimeMinutes': cookingTime,
        'region': regionController.text.trim(),
        'ingredients': ingredients,
        'steps': steps,
      };

      final youtube = youtubeUrlController.text.trim();
      if (youtube.isNotEmpty) {
        data['youtubeUrl'] = youtube;
      }

      await createRecipeUseCase(data, imageFile: selectedImage);

      emit(AddRecipeSuccess());
      _clearForm();
    } catch (e) {
      emit(AddRecipeError(e.toString()));
    }
  }

  void _clearForm() {
    selectedImage = null;
    nameController.clear();
    descriptionController.clear();
    categoryController.clear();
    kitchenTypeController.clear();
    cookingTimeController.clear();
    youtubeUrlController.clear();
    regionController.clear();
    ingredientsController.clear();
    for (var element in stepControllers) {
      element.dispose();
    }
    stepControllers.clear();
    stepControllers.add(TextEditingController(text: "Open bag."));
    stepControllers.add(TextEditingController());
  }

  @override
  Future<void> close() {
    nameController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    kitchenTypeController.dispose();
    cookingTimeController.dispose();
    youtubeUrlController.dispose();
    regionController.dispose();
    ingredientsController.dispose();
    for (var element in stepControllers) {
      element.dispose();
    }
    return super.close();
  }
}
