import 'package:flutter/material.dart';

@immutable
abstract class AddRecipeState {}

class AddRecipeInitial extends AddRecipeState {}

class AddRecipeLoading extends AddRecipeState {}

class AddRecipeSuccess extends AddRecipeState {}

class AddRecipeError extends AddRecipeState {
  final String message;
  AddRecipeError(this.message);
}
