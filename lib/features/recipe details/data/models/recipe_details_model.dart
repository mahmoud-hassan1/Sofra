import 'package:sofra/features/home/data/models/recipe_model.dart';
import '../../domain/entities/recipe_details_entity.dart';

class IngredientModel extends IngredientEntity {
  const IngredientModel({required super.name, required super.quantity});

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
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
    
    final stepsList = stepsJson.map((e) => RecipeStepModel.fromJson(e as Map<String, dynamic>)).toList();
    stepsList.sort((a, b) => a.order.compareTo(b.order));

    return RecipeDetailsModel(
      id: data['id'] ?? '',
      title: data['name'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      region: data['region'] ?? '',
      kitchenType: data['kitchenType'] ?? '',
      cookingTimeMinutes: data['cookingTimeMinutes'] ?? 0,
      youtubeUrl: data['youtubeUrl'],
      imageUrl: data['imageUrl'] ?? '',
      ingredients: ingredientsJson.map((e) => IngredientModel.fromJson(e as Map<String, dynamic>)).toList(),
      steps: stepsList,
      likeCount: data['likeCount'] ?? 0,
      isSaved: data['isSaved'] ?? false,
      owner: data['owner'] != null ? RecipeOwnerModel.fromJson(data['owner']) : null,
      createdAt: data['createdAt'] ?? '',
    );
  }
}
