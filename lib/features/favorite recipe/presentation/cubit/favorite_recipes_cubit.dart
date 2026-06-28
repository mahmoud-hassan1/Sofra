import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/features/home/domain/entities/recipe_entity.dart';
import '../../domain/usecases/get_saved_recipes_usecase.dart';

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

  FavoriteRecipesCubit({required this.getSavedRecipesUseCase})
      : super(const FavoriteRecipesState());

  Future<void> loadSavedRecipes() async {
    emit(state.copyWith(status: FavoriteRecipesStatus.loading));
    try {
      final recipes = await getSavedRecipesUseCase();
      emit(state.copyWith(
        status: FavoriteRecipesStatus.success,
        recipes: recipes,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FavoriteRecipesStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
