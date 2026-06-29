import 'package:get_it/get_it.dart';
import 'package:sofra/core/network/api_service.dart';

// Auth
import 'package:sofra/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:sofra/features/auth/domain/repositories/auth_repository.dart';
import 'package:sofra/features/auth/domain/repositories/auth_repository_impl.dart';
import 'package:sofra/features/auth/presentation/cubit/auth_cubit.dart';

// Home
import 'package:sofra/features/home/data/repositories/recipe_repository_impl.dart';
import 'package:sofra/features/home/domain/repositories/recipe_repository.dart';
import 'package:sofra/features/home/domain/usecases/get_recipes_usecase.dart';
import 'package:sofra/features/home/domain/usecases/toggle_save_recipe_usecase.dart';
import 'package:sofra/features/home/domain/usecases/get_top_liked_recipe_usecase.dart';

// Recipe Details
import 'package:sofra/features/recipe%20details/data/datasources/recipe_details_remote_data_source.dart';
import 'package:sofra/features/recipe%20details/data/repositories/recipe_details_repository_impl.dart';
import 'package:sofra/features/recipe%20details/domain/repositories/recipe_details_repository.dart';
import 'package:sofra/features/recipe%20details/domain/usecases/get_recipe_details_usecase.dart';
import 'package:sofra/features/recipe%20details/presentation/cubit/recipe_details_cubit.dart';

// Favorite Recipes
import 'package:sofra/features/favorite%20recipe/data/datasources/favorite_recipes_remote_data_source.dart';
import 'package:sofra/features/favorite%20recipe/data/repositories/favorite_recipes_repository_impl.dart';
import 'package:sofra/features/favorite%20recipe/domain/repositories/favorite_recipes_repository.dart';
import 'package:sofra/features/favorite%20recipe/domain/usecases/get_saved_recipes_usecase.dart';
import 'package:sofra/features/favorite%20recipe/presentation/cubit/favorite_recipes_cubit.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  // Core
  sl.registerLazySingleton(() => ApiService());

  // Auth
  sl.registerFactory(() => AuthCubit(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  // Home
  sl.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImpl(apiService: sl()),
  );
  sl.registerLazySingleton(() => GetRecipesUseCase(sl()));
  sl.registerLazySingleton(() => ToggleSaveRecipeUseCase(sl()));
  sl.registerLazySingleton(() => GetTopLikedRecipeUseCase(sl()));

  // Recipe Details
  sl.registerFactory(() => RecipeDetailsCubit(getRecipeDetailsUseCase: sl()));
  sl.registerLazySingleton(() => GetRecipeDetailsUseCase(sl()));
  sl.registerLazySingleton<RecipeDetailsRepository>(
    () => RecipeDetailsRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<RecipeDetailsRemoteDataSource>(
    () => RecipeDetailsRemoteDataSourceImpl(sl()),
  );

  // Favorite Recipes
  sl.registerFactory(
    () => FavoriteRecipesCubit(getSavedRecipesUseCase: sl()),
  );
  sl.registerLazySingleton(() => GetSavedRecipesUseCase(sl()));
  sl.registerLazySingleton<FavoriteRecipesRepository>(
    () => FavoriteRecipesRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<FavoriteRecipesRemoteDataSource>(
    () => FavoriteRecipesRemoteDataSourceImpl(sl()),
  );
}
