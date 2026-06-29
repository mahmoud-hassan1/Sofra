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

  @override
  Future<RecipeEntity> createRecipe(
    Map<String, dynamic> data, {
    File? imageFile,
  }) async {
    // STEP 1: Upload image to Cloudinary via the media endpoint (if provided)
    String? uploadedImageUrl;
    if (imageFile != null) {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });
      final uploadResponse = await apiService.postMultipart(
        endpoint: 'media/recipe-image',
        formData: formData,
      );
      final uploadData = uploadResponse.data is String
          ? jsonDecode(uploadResponse.data as String) as Map<String, dynamic>
          : uploadResponse.data as Map<String, dynamic>;

      if (uploadData['success'] != true) {
        throw Exception(uploadData['error']?['message'] ?? 'Image upload failed');
      }
      uploadedImageUrl = uploadData['data']['imageUrl'] as String?;
    }

    // STEP 2: Create the recipe, now including the Cloudinary URL if we got one
    final Map<String, dynamic> payload = {
      'name': data['name'],
      'description': data['description'],
      'category': data['category'],
      'kitchenType': data['kitchenType'],
      'cookingTimeMinutes': data['cookingTimeMinutes'],
      'region': data['region'],
      'ingredients': data['ingredients'],
      'steps': data['steps'],
      'location': data['location'],
      'imageUrl': uploadedImageUrl,
      if (data['youtubeUrl'] != null &&
          (data['youtubeUrl'] as String).isNotEmpty)
        'youtubeUrl': data['youtubeUrl'],
    };

    final response = await apiService.post(endpoint: 'recipes', data: payload);

    // Dio sometimes returns the body as a String if responseType isn't set
    final responseData = response.data is String
        ? jsonDecode(response.data as String) as Map<String, dynamic>
        : response.data as Map<String, dynamic>;

    if (responseData['success'] == false) {
      throw Exception(
        responseData['error']?['message'] ?? 'Failed to create recipe',
      );
    }

    final recipeData = responseData['data'];
    if (recipeData == null) {
      throw Exception('No data returned from server');
    }

    return RecipeModel.fromJson(recipeData as Map<String, dynamic>);
  }
}
