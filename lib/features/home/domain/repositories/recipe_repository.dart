import 'package:sofra/features/home/domain/entities/recipe_entity.dart';

abstract class RecipeRepository {
  Future<List<RecipeEntity>> getRecipes({String? search, String? region, String? category});
  Future<bool> toggleSaveRecipe(String recipeId);
}
