import 'package:sofra/core/network/api_service.dart';
import 'package:sofra/features/home/data/models/recipe_model.dart';
import 'package:sofra/features/home/domain/entities/recipe_entity.dart';
import 'package:sofra/features/home/domain/repositories/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final ApiService apiService;

  RecipeRepositoryImpl({required this.apiService});

  @override
  Future<List<RecipeEntity>> getRecipes({String? search, String? region, String? category}) async {
    final List<dynamic> data = await apiService.getRecipes(
      search: search,
      region: region,
      category: category,
    );
    final List<RecipeEntity> recipes = [];
    for (int i = 0; i < data.length; i++) {
      recipes.add(RecipeModel.fromJson(data[i] as Map<String, dynamic>, index: i));
    }
    return recipes;
  }

  @override
  Future<bool> toggleSaveRecipe(String recipeId) async {
    final response = await apiService.toggleSaveRecipe(recipeId);
    return response['data']['isSaved'] as bool;
  }
}
