import 'package:sofra/features/home/domain/entities/recipe_entity.dart';

// IngredientEntity is intentionally NOT re-declared here.
// It is imported from the home layer (recipe_entity.dart) to avoid a
// duplicate-symbol conflict with the home layer's own IngredientEntity class.

class RecipeStepEntity {
  final int order;
  final String text;
  const RecipeStepEntity({required this.order, required this.text});
}

class RecipeDetailsEntity {
  final String id;
  final String title;
  final String description;
  final String category;
  final String region;
  final String kitchenType;
  final int cookingTimeMinutes;
  final String? youtubeUrl;
  final String imageUrl;
  final List<IngredientEntity> ingredients;
  final List<RecipeStepEntity> steps;
  final int likeCount;
  final bool isSaved;
  final RecipeOwnerEntity? owner;
  final String createdAt;

  const RecipeDetailsEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.region,
    required this.kitchenType,
    required this.cookingTimeMinutes,
    this.youtubeUrl,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.likeCount,
    required this.isSaved,
    this.owner,
    required this.createdAt,
  });

  String get deliveryTime => '${cookingTimeMinutes}m';
}
