import 'package:sofra/core/network/api_constants.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/features/home/domain/entities/recipe_entity.dart';

class RecipeOwnerModel extends RecipeOwnerEntity {
  const RecipeOwnerModel({
    required super.id,
    required super.displayName,
    super.avatarUrl,
  });

  factory RecipeOwnerModel.fromJson(Map<String, dynamic> json) {
    return RecipeOwnerModel(
      id: json['id'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'avatarUrl': avatarUrl,
    };
  }
}

class RecipeModel extends RecipeEntity {
  const RecipeModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.region,
    required super.kitchenType,
    required super.cookingTimeMinutes,
    required super.imageUrl,
    required super.likeCount,
    required super.isSaved,
    super.owner,
    required super.tags,
    required super.bgColor,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json, {int index = 0}) {
    final title = json['name'] as String? ?? json['title'] as String? ?? '';
    final region = json['region'] as String? ?? '';
    final kitchenType = json['kitchenType'] as String? ?? '';
    
    final tags = (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ??
        [region, kitchenType].where((t) => t.isNotEmpty).toList();

    final bgColor = index % 2 == 0 
        ? AppColors.secondaryColor[200]! 
        : AppColors.pinkAccentColor;

    var imageUrl = json['imageUrl'] as String? ?? '';
    if (imageUrl.isNotEmpty && !imageUrl.startsWith('http') && !imageUrl.startsWith('assets/')) {
      final cleanPath = imageUrl.startsWith('/') ? imageUrl.substring(1) : imageUrl;
      final serverRoot = ApiConstants.baseUrl.replaceAll('/api/', '');
      imageUrl = '$serverRoot/$cleanPath';
    }

    return RecipeModel(
      id: json['id'] as String? ?? '',
      title: title,
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      region: region,
      kitchenType: kitchenType,
      cookingTimeMinutes: json['cookingTimeMinutes'] as int? ?? 0,
      imageUrl: imageUrl,
      likeCount: json['likeCount'] as int? ?? 0,
      isSaved: json['isSaved'] as bool? ?? false,
      owner: json['owner'] != null
          ? RecipeOwnerModel.fromJson(json['owner'] as Map<String, dynamic>)
          : null,
      tags: tags,
      bgColor: bgColor,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': title,
      'description': description,
      'category': category,
      'region': region,
      'kitchenType': kitchenType,
      'cookingTimeMinutes': cookingTimeMinutes,
      'imageUrl': imageUrl,
      'likeCount': likeCount,
      'isSaved': isSaved,
      'owner': owner != null ? (owner as RecipeOwnerModel).toJson() : null,
      'tags': tags,
    };
  }
}
