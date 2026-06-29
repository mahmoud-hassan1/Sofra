import 'package:sofra/core/network/api_service.dart';
import 'package:sofra/features/home/data/models/recipe_model.dart';
import 'package:sofra/features/home/domain/entities/recipe_entity.dart';

abstract class PostsRemoteDataSource {
  Future<List<RecipeEntity>> getMyRecipes();
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final ApiService apiService;
  PostsRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<RecipeEntity>> getMyRecipes() async {
    final response = await apiService.get(endpoint: 'recipes/me');

    final List<dynamic> data = (response.data['data'] as List<dynamic>? ?? []);

    return data
        .asMap()
        .entries
        .map(
          (e) => RecipeModel.fromJson(
            e.value as Map<String, dynamic>,
            index: e.key,
          ),
        )
        .toList();
  }
}
