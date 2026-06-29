import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/features/home/domain/entities/recipe_entity.dart';
import '../../domain/usecases/get_saved_recipes_usecase.dart';
import '../../../home/domain/usecases/toggle_save_recipe_usecase.dart';

enum FavoriteRecipesStatus { initial, loading, success, failure }

class FavoriteRecipesState {
  final FavoriteRecipesStatus status;
  final List<RecipeEntity> recipes;
  final String? errorMessage;

  const FavoriteRecipesState({
    this.status = FavoriteRecipesStatus.initial,
    this.recipes = const [],
    this.errorMessage,
  });

  FavoriteRecipesState copyWith({
    FavoriteRecipesStatus? status,
    List<RecipeEntity>? recipes,
    String? errorMessage,
  }) {
    return FavoriteRecipesState(
      status: status ?? this.status,
      recipes: recipes ?? this.recipes,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class FavoriteRecipesCubit extends Cubit<FavoriteRecipesState> {
  final GetSavedRecipesUseCase getSavedRecipesUseCase;
  final ToggleSaveRecipeUseCase toggleSaveRecipeUseCase;

  FavoriteRecipesCubit({
    required this.getSavedRecipesUseCase,
    required this.toggleSaveRecipeUseCase,
  }) : super(const FavoriteRecipesState());

  Future<void> loadSavedRecipes() async {
    emit(state.copyWith(status: FavoriteRecipesStatus.loading));
    try {
      final recipes = await getSavedRecipesUseCase();
      emit(
        state.copyWith(status: FavoriteRecipesStatus.success, recipes: recipes),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FavoriteRecipesStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> toggleFavorite(String id) async {
    final previousRecipes = List<RecipeEntity>.from(state.recipes);
    final updatedRecipes = previousRecipes.where((r) => r.id != id).toList();

    emit(state.copyWith(recipes: updatedRecipes));

    try {
      await toggleSaveRecipeUseCase(id);
    } catch (e) {
      emit(state.copyWith(recipes: previousRecipes));
    }
  }
}
