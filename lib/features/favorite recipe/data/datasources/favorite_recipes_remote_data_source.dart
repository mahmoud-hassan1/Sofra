import 'package:sofra/core/network/api_service.dart';

abstract class FavoriteRecipesRemoteDataSource {
  Future<List<dynamic>> getSavedRecipes();
}

class FavoriteRecipesRemoteDataSourceImpl implements FavoriteRecipesRemoteDataSource {
  final ApiService apiService;
  FavoriteRecipesRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<dynamic>> getSavedRecipes() async {
    return apiService.getSavedRecipes();
  }
}
