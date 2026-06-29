import 'package:dio/dio.dart';
import 'package:sofra/features/home/domain/entities/recipe_entity.dart';
import 'package:sofra/features/posts/data/data_sources/posts_remote_data_source.dart';
import 'package:sofra/features/posts/domain/repositories/posts_repository.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsRemoteDataSource remoteDataSource;
  PostsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<RecipeEntity>> getMyRecipes() async {
    try {
      return await remoteDataSource.getMyRecipes();
    } on DioException catch (e) {
      final msg = e.response?.data['message'] ?? e.message ?? 'Unknown error';
      throw Exception(msg);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
