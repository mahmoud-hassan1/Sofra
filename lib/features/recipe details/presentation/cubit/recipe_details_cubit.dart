import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/recipe_details_entity.dart';
import '../../domain/usecases/get_recipe_details_usecase.dart';

enum RecipeDetailsStatus { initial, loading, success, failure }

class RecipeDetailsState {
  final RecipeDetailsStatus status;
  final RecipeDetailsEntity? recipe;
  final String? errorMessage;

  const RecipeDetailsState({
    this.status = RecipeDetailsStatus.initial,
    this.recipe,
    this.errorMessage,
  });

  RecipeDetailsState copyWith({
    RecipeDetailsStatus? status,
    RecipeDetailsEntity? recipe,
    String? errorMessage,
  }) {
    return RecipeDetailsState(
      status: status ?? this.status,
      recipe: recipe ?? this.recipe,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class RecipeDetailsCubit extends Cubit<RecipeDetailsState> {
  final GetRecipeDetailsUseCase getRecipeDetailsUseCase;

  RecipeDetailsCubit({required this.getRecipeDetailsUseCase})
      : super(const RecipeDetailsState());

  Future<void> loadRecipeDetails(String recipeId) async {
    emit(state.copyWith(status: RecipeDetailsStatus.loading));
    try {
      final recipe = await getRecipeDetailsUseCase(recipeId);
      emit(state.copyWith(status: RecipeDetailsStatus.success, recipe: recipe));
    } catch (e) {
      emit(state.copyWith(
        status: RecipeDetailsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
