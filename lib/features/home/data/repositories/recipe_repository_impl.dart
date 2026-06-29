import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sofra/core/network/api_service.dart';
import 'package:sofra/features/home/data/models/recipe_model.dart';
import 'package:sofra/features/home/domain/entities/recipe_entity.dart';
import 'package:sofra/features/home/domain/repositories/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final ApiService apiService;

  RecipeRepositoryImpl({required this.apiService});

  @override
  Future<List<RecipeEntity>> getRecipes({
    String? search,
    String? region,
    String? category,
  }) async {
    final List<dynamic> data = await apiService.getRecipes(
      search: search,
      region: region,
      category: category,
    );
    final List<RecipeEntity> recipes = [];
    for (int i = 0; i < data.length; i++) {
      recipes.add(
        RecipeModel.fromJson(data[i] as Map<String, dynamic>, index: i),
      );
    }
    return recipes;
  }

  @override
  Future<bool> toggleSaveRecipe(String recipeId) async {
    final response = await apiService.toggleSaveRecipe(recipeId);
    return response['data']['isSaved'] as bool;
  }

  @override
  Future<RecipeEntity?> getTopLikedRecipe() async {
    final List<dynamic> data = await apiService.getTopLikedRecipes(limit: 1);
    if (data.isEmpty) return null;
    return RecipeModel.fromJson(data[0] as Map<String, dynamic>);
  }

  Future<RecipeEntity> createRecipe(
    Map<String, dynamic> data, {
    File? imageFile,
  }) async {
    dynamic payload = data;

    if (imageFile != null) {
      final Map<String, dynamic> formDataMap = {};
      data.forEach((key, value) {
        if (value is List || value is Map) {
          formDataMap[key] = jsonEncode(value);
        } else {
          formDataMap[key] = value;
        }
      });
      final formData = FormData.fromMap(formDataMap);
      final fileName = imageFile.path.split('/').last;

      formData.files.add(
        MapEntry(
          'image',
          await MultipartFile.fromFile(imageFile.path, filename: fileName),
        ),
      );

      final response = await apiService.postMultipart(
        endpoint: 'recipes',
        formData: formData,
      );
      if (response.data['success'] == false) {
        throw Exception(
          response.data['error']?['message'] ?? 'Failed to create recipe',
        );
      }
      return RecipeModel.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } else {
      final response = await apiService.post(
        endpoint: 'recipes',
        data: payload,
      );
      if (response.data['success'] == false) {
        throw Exception(
          response.data['error']?['message'] ?? 'Failed to create recipe',
        );
      }
      return RecipeModel.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    }
  }
}
