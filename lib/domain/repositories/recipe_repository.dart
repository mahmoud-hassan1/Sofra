import 'package:sofra/domain/entities/recipe_entity.dart';

abstract class RecipeRepository {
  Future<List<RecipeEntity>> getRecipes({String? search, String? region, String? category});
  Future<bool> toggleSaveRecipe(String recipeId);
}
