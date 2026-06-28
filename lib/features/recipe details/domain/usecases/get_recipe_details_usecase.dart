import '../entities/recipe_details_entity.dart';
import '../repositories/recipe_details_repository.dart';

class GetRecipeDetailsUseCase {
  final RecipeDetailsRepository repository;

  GetRecipeDetailsUseCase(this.repository);

  Future<RecipeDetailsEntity> call(String recipeId) {
    return repository.getRecipeDetails(recipeId);
  }
}
