part of 'posts_cubit.dart';

abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  final List<RecipeEntity> allPosts;

  final String searchQuery;

  PostsLoaded(this.allPosts, {this.searchQuery = ''});

  List<RecipeEntity> get filteredPosts {
    if (searchQuery.trim().isEmpty) return allPosts;
    final q = searchQuery.toLowerCase();
    return allPosts.where((r) {
      return r.title.toLowerCase().contains(q) ||
          r.category.toLowerCase().contains(q) ||
          r.description.toLowerCase().contains(q);
    }).toList();
  }

  PostsLoaded copyWithSearch(String query) =>
      PostsLoaded(allPosts, searchQuery: query);
}

class PostsError extends PostsState {
  final String message;
  PostsError(this.message);
}
