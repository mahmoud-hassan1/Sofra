import 'dart:io';

import 'package:sofra/features/home/domain/entities/recipe_entity.dart';
import 'package:sofra/features/home/domain/repositories/recipe_repository.dart';

class CreateRecipeUseCase {
  final RecipeRepository repository;

  CreateRecipeUseCase(this.repository);

  Future<RecipeEntity> call(Map<String, dynamic> data, {File? imageFile}) async {
    return await repository.createRecipe(data, imageFile: imageFile);
  }
}
