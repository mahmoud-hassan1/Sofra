import 'package:sofra/features/home/domain/entities/recipe_entity.dart';
import 'package:sofra/features/home/domain/repositories/recipe_repository.dart';

class GetTopLikedRecipeUseCase {
  final RecipeRepository repository;

  GetTopLikedRecipeUseCase(this.repository);

  Future<RecipeEntity?> call() {
    return repository.getTopLikedRecipe();
  }
}
