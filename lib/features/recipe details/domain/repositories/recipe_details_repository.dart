import '../entities/recipe_details_entity.dart';

abstract class RecipeDetailsRepository {
  Future<RecipeDetailsEntity> getRecipeDetails(String recipeId);
}
