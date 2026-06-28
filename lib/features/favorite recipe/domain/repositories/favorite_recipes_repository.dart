import 'package:sofra/features/home/domain/entities/recipe_entity.dart';

abstract class FavoriteRecipesRepository {
  Future<List<RecipeEntity>> getSavedRecipes();
}
