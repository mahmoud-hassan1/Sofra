import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/features/home/domain/entities/recipe_entity.dart';
import 'package:sofra/features/posts/domain/repositories/posts_repository.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsRepository postsRepository;

  PostsCubit(this.postsRepository) : super(PostsInitial());

  Future<void> loadMyRecipes() async {
    emit(PostsLoading());
    try {
      final posts = await postsRepository.getMyRecipes();
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  void search(String query) {
    final current = state;
    if (current is PostsLoaded) {
      emit(current.copyWithSearch(query));
    }
  }

  void clearSearch() => search('');
}
