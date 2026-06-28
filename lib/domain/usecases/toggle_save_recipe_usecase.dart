import 'package:sofra/domain/repositories/recipe_repository.dart';

class ToggleSaveRecipeUseCase {
  final RecipeRepository repository;

  ToggleSaveRecipeUseCase(this.repository);

  Future<bool> call(String recipeId) {
    return repository.toggleSaveRecipe(recipeId);
  }
}
