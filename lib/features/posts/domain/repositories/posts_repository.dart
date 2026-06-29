import 'package:sofra/features/home/domain/entities/recipe_entity.dart';

abstract class PostsRepository {
  Future<List<RecipeEntity>> getMyRecipes();
}
