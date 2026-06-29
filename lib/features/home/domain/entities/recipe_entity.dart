import 'package:flutter/material.dart';

class RecipeOwnerEntity {
  final String id;
  final String displayName;
  final String? avatarUrl;

  const RecipeOwnerEntity({
    required this.id,
    required this.displayName,
    this.avatarUrl,
  });
}

class IngredientEntity {
  final String name;
  final String quantity;

  const IngredientEntity({
    required this.name,
    required this.quantity,
  });
}

class StepEntity {
  final int order;
  final String text;

  const StepEntity({
    required this.order,
    required this.text,
  });
}

class LocationEntity {
  final double lat;
  final double lng;

  const LocationEntity({
    required this.lat,
    required this.lng,
  });
}

class RecipeEntity {
  final String id;
  final String title;
  final String description;
  final String category;
  final String region;
  final String kitchenType;
  final int cookingTimeMinutes;
  final String imageUrl;
  final int likeCount;
  final bool isSaved;
  final RecipeOwnerEntity? owner;
  final List<String> tags;
  final Color bgColor;
  
  final String? youtubeUrl;
  final List<IngredientEntity>? ingredients;
  final List<StepEntity>? steps;
  final LocationEntity? location;

  const RecipeEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.region,
    required this.kitchenType,
    required this.cookingTimeMinutes,
    required this.imageUrl,
    required this.likeCount,
    required this.isSaved,
    this.owner,
    required this.tags,
    required this.bgColor,
    this.youtubeUrl,
    this.ingredients,
    this.steps,
    this.location,
  });

  String get deliveryTime => '${cookingTimeMinutes}m';

  RecipeEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? region,
    String? kitchenType,
    int? cookingTimeMinutes,
    String? imageUrl,
    int? likeCount,
    bool? isSaved,
    RecipeOwnerEntity? owner,
    List<String>? tags,
    Color? bgColor,
    String? youtubeUrl,
    List<IngredientEntity>? ingredients,
    List<StepEntity>? steps,
    LocationEntity? location,
  }) {
    return RecipeEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      region: region ?? this.region,
      kitchenType: kitchenType ?? this.kitchenType,
      cookingTimeMinutes: cookingTimeMinutes ?? this.cookingTimeMinutes,
      imageUrl: imageUrl ?? this.imageUrl,
      likeCount: likeCount ?? this.likeCount,
      isSaved: isSaved ?? this.isSaved,
      owner: owner ?? this.owner,
      tags: tags ?? this.tags,
      bgColor: bgColor ?? this.bgColor,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      location: location ?? this.location,
    );
  }
}
