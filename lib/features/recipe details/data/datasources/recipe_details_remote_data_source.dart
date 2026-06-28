import 'package:sofra/core/network/api_service.dart';

abstract class RecipeDetailsRemoteDataSource {
  Future<Map<String, dynamic>> getRecipeDetails(String recipeId);
}

class RecipeDetailsRemoteDataSourceImpl implements RecipeDetailsRemoteDataSource {
  final ApiService apiService;
  RecipeDetailsRemoteDataSourceImpl(this.apiService);

  @override
  Future<Map<String, dynamic>> getRecipeDetails(String recipeId) async {
    return apiService.getRecipeDetails(recipeId);
  }
}
