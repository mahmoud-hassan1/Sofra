import 'package:sofra/core/network/api_constants.dart';
import 'package:sofra/features/home/data/models/recipe_model.dart';
import 'package:sofra/features/home/domain/entities/recipe_entity.dart'
    show IngredientEntity;
import '../../domain/entities/recipe_details_entity.dart';

/// Renamed from [IngredientModel] to avoid a symbol conflict with the
/// identically-named class in `recipe_model.dart` (home layer).
class RecipeDetailsIngredientModel extends IngredientEntity {
  const RecipeDetailsIngredientModel({
    required super.name,
    required super.quantity,
  });

  factory RecipeDetailsIngredientModel.fromJson(Map<String, dynamic> json) {
    return RecipeDetailsIngredientModel(
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? '',
    );
  }
}

class RecipeStepModel extends RecipeStepEntity {
  const RecipeStepModel({required super.order, required super.text});

  factory RecipeStepModel.fromJson(Map<String, dynamic> json) {
    return RecipeStepModel(
      order: json['order'] ?? 0,
      text: json['text'] ?? '',
    );
  }
}

class RecipeDetailsModel extends RecipeDetailsEntity {
  const RecipeDetailsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.region,
    required super.kitchenType,
    required super.cookingTimeMinutes,
    super.youtubeUrl,
    required super.imageUrl,
    required super.ingredients,
    required super.steps,
    required super.likeCount,
    required super.isSaved,
    super.owner,
    required super.createdAt,
  });

  factory RecipeDetailsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};

    final ingredientsJson = data['ingredients'] as List? ?? [];
    final stepsJson = data['steps'] as List? ?? [];

    final stepsList = stepsJson
        .map((e) => RecipeStepModel.fromJson(e as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));

    // Normalise imageUrl — mirror the logic in RecipeModel.fromJson so both
    // screens behave consistently. Cloudinary URLs start with 'http' and
    // pass through unchanged; relative paths get the server root prepended.
    var imageUrl = data['imageUrl'] as String? ?? '';
    if (imageUrl.isNotEmpty &&
        !imageUrl.startsWith('http') &&
        !imageUrl.startsWith('assets/')) {
      final cleanPath =
          imageUrl.startsWith('/') ? imageUrl.substring(1) : imageUrl;
      final serverRoot = ApiConstants.baseUrl.replaceAll('/api/', '');
      imageUrl = '$serverRoot/$cleanPath';
    }

    return RecipeDetailsModel(
      id: data['id'] ?? '',
      title: data['name'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      region: data['region'] ?? '',
      kitchenType: data['kitchenType'] ?? '',
      cookingTimeMinutes: data['cookingTimeMinutes'] ?? 0,
      youtubeUrl: data['youtubeUrl'],
      imageUrl: imageUrl,
      ingredients: ingredientsJson
          .map((e) =>
              RecipeDetailsIngredientModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      steps: stepsList,
      likeCount: data['likeCount'] ?? 0,
      isSaved: data['isSaved'] ?? false,
      owner: data['owner'] != null
          ? RecipeOwnerModel.fromJson(data['owner'] as Map<String, dynamic>)
          : null,
      createdAt: data['createdAt'] ?? '',
    );
  }
}
