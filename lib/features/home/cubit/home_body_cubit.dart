import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/domain/entities/recipe_entity.dart';
import 'package:sofra/domain/usecases/get_recipes_usecase.dart';
import 'package:sofra/domain/usecases/toggle_save_recipe_usecase.dart';

enum HomeBodyStatus { initial, loading, success, failure }

class HomeBodyState {
  final HomeBodyStatus status;
  final List<RecipeEntity> recipes;
  final String searchQuery;
  final String selectedRegion;
  final String? errorMessage;

  const HomeBodyState({
    this.status = HomeBodyStatus.initial,
    this.recipes = const [],
    this.searchQuery = '',
    this.selectedRegion = 'All',
    this.errorMessage,
  });

  HomeBodyState copyWith({
    HomeBodyStatus? status,
    List<RecipeEntity>? recipes,
    String? searchQuery,
    String? selectedRegion,
    String? errorMessage,
  }) {
    return HomeBodyState(
      status: status ?? this.status,
      recipes: recipes ?? this.recipes,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedRegion: selectedRegion ?? this.selectedRegion,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class HomeBodyCubit extends Cubit<HomeBodyState> {
  final GetRecipesUseCase getRecipesUseCase;
  final ToggleSaveRecipeUseCase toggleSaveRecipeUseCase;

  HomeBodyCubit({
    required this.getRecipesUseCase,
    required this.toggleSaveRecipeUseCase,
  }) : super(const HomeBodyState());

  Future<void> loadRecipes() async {
    emit(state.copyWith(status: HomeBodyStatus.loading));
    try {
      final recipes = await getRecipesUseCase(
        search: state.searchQuery,
        region: state.selectedRegion,
      );
      emit(state.copyWith(
        status: HomeBodyStatus.success,
        recipes: recipes,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HomeBodyStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void changeSearchQuery(String query) {
    if (state.searchQuery == query) return;
    emit(state.copyWith(searchQuery: query));
    loadRecipes();
  }

  void changeRegion(String region) {
    if (state.selectedRegion == region) return;
    emit(state.copyWith(selectedRegion: region));
    loadRecipes();
  }

  Future<void> toggleSaveRecipe(String recipeId) async {
    final index = state.recipes.indexWhere((r) => r.id == recipeId);
    if (index == -1) return;

    final originalRecipe = state.recipes[index];
    final updatedRecipes = List<RecipeEntity>.from(state.recipes);

    final bool newIsSaved = !originalRecipe.isSaved;
    final int newLikeCount = newIsSaved 
        ? originalRecipe.likeCount + 1 
        : (originalRecipe.likeCount - 1).clamp(0, 999999);

    updatedRecipes[index] = originalRecipe.copyWith(
      isSaved: newIsSaved,
      likeCount: newLikeCount,
    );
    emit(state.copyWith(recipes: updatedRecipes));

    try {
      final backendSaved = await toggleSaveRecipeUseCase(recipeId);
      if (backendSaved != newIsSaved) {
        final latestRecipes = List<RecipeEntity>.from(state.recipes);
        final latestIndex = latestRecipes.indexWhere((r) => r.id == recipeId);
        if (latestIndex != -1) {
          final diff = backendSaved ? 1 : -1;
          latestRecipes[latestIndex] = originalRecipe.copyWith(
            isSaved: backendSaved,
            likeCount: (originalRecipe.likeCount + diff).clamp(0, 999999),
          );
          emit(state.copyWith(recipes: latestRecipes));
        }
      }
    } catch (e) {
      final revertedRecipes = List<RecipeEntity>.from(state.recipes);
      final revertedIndex = revertedRecipes.indexWhere((r) => r.id == recipeId);
      if (revertedIndex != -1) {
        revertedRecipes[revertedIndex] = originalRecipe;
        emit(state.copyWith(recipes: revertedRecipes));
      }
    }
  }

  void clearFilters() {
    emit(state.copyWith(
      searchQuery: '',
      selectedRegion: 'All',
    ));
    loadRecipes();
  }
}