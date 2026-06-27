import 'package:sofra/domain/entities/recipe_entity.dart';
import 'package:sofra/domain/repositories/recipe_repository.dart';

class GetRecipesUseCase {
  final RecipeRepository repository;

  GetRecipesUseCase(this.repository);

  Future<List<RecipeEntity>> call({String? search, String? region, String? category}) {
    return repository.getRecipes(
      search: search,
      region: region,
      category: category,
    );
  }
}
