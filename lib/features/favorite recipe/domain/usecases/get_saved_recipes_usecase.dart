import 'package:sofra/features/home/domain/entities/recipe_entity.dart';
import '../repositories/favorite_recipes_repository.dart';

class GetSavedRecipesUseCase {
  final FavoriteRecipesRepository repository;
  GetSavedRecipesUseCase(this.repository);

  Future<List<RecipeEntity>> call() {
    return repository.getSavedRecipes();
  }
}
