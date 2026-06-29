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
    if (nameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        categoryController.text.isEmpty ||
        kitchenTypeController.text.isEmpty ||
        cookingTimeController.text.isEmpty ||
        regionController.text.isEmpty ||
        ingredientsController.text.isEmpty) {
      emit(AddRecipeError('Please fill in all required fields.'));
      return;
    }

    final int? cookingTime = int.tryParse(cookingTimeController.text);
    if (cookingTime == null) {
      emit(AddRecipeError('Please enter a valid cooking time.'));
      return;
    }

    emit(AddRecipeLoading());

    try {
      final List<Map<String, dynamic>> ingredients = [];
      final ingredientLines = ingredientsController.text.split('\n');
      for (var line in ingredientLines) {
        final trimmedLine = line.trim();
        if (trimmedLine.isNotEmpty) {
          final parts = trimmedLine.split(' ');
          final quantity = parts.first;
          final name = parts.skip(1).join(' ');
          ingredients.add({
            'name': name.isEmpty ? trimmedLine : name,
            'quantity': name.isEmpty ? '1' : quantity,
          });
        }
      }

      final List<Map<String, dynamic>> steps = [];
      for (int i = 0; i < stepControllers.length; i++) {
        final text = stepControllers[i].text.trim();
        if (text.isNotEmpty) {
          steps.add({'order': i + 1, 'text': text});
        }
      }

      final data = {
        'name': nameController.text.trim(),
        'description': descriptionController.text.trim(),
        'category': categoryController.text.trim(),
        'kitchenType': kitchenTypeController.text.trim(),
        'cookingTimeMinutes': cookingTime,
        'region': regionController.text.trim(),
        'ingredients': ingredients,
        'steps': steps,
      };

      if (youtubeUrlController.text.isNotEmpty) {
        data['youtubeUrl'] = youtubeUrlController.text.trim();
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
