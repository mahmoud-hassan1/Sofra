import 'package:dio/dio.dart';
import '../../domain/entities/recipe_details_entity.dart';
import '../../domain/repositories/recipe_details_repository.dart';
import '../datasources/recipe_details_remote_data_source.dart';
import '../models/recipe_details_model.dart';

class RecipeDetailsRepositoryImpl implements RecipeDetailsRepository {
  final RecipeDetailsRemoteDataSource remoteDataSource;

  RecipeDetailsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<RecipeDetailsEntity> getRecipeDetails(String recipeId) async {
    try {
      final response = await remoteDataSource.getRecipeDetails(recipeId);
      return RecipeDetailsModel.fromJson(response);
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Failed to load recipe details');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
