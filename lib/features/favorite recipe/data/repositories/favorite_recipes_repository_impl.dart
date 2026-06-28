import 'package:dio/dio.dart';
import 'package:sofra/features/home/data/models/recipe_model.dart';
import 'package:sofra/features/home/domain/entities/recipe_entity.dart';
import '../../domain/repositories/favorite_recipes_repository.dart';
import '../datasources/favorite_recipes_remote_data_source.dart';

class FavoriteRecipesRepositoryImpl implements FavoriteRecipesRepository {
  final FavoriteRecipesRemoteDataSource remoteDataSource;

  FavoriteRecipesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<RecipeEntity>> getSavedRecipes() async {
    try {
      final response = await remoteDataSource.getSavedRecipes();
      List<RecipeEntity> recipes = [];
      for (int i = 0; i < response.length; i++) {
        recipes.add(RecipeModel.fromJson(response[i], index: i));
      }
      return recipes;
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Failed to load saved recipes');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
