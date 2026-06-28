
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
    );
  }
}
