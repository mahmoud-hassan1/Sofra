import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/core/services/service_locator.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:sofra/features/posts/presentation/widgets/empty_posts.dart';
import 'package:sofra/features/posts/presentation/widgets/empty_search.dart';
import 'package:sofra/features/posts/presentation/widgets/posts_app_bar.dart';
import 'package:sofra/features/posts/presentation/widgets/posts_error_widget.dart';
import 'package:sofra/features/posts/presentation/widgets/posts_list.dart';

class PostsScreenBody extends StatelessWidget {
  const PostsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PostsCubit>()..loadMyRecipes(),
      child: const _PostsContent(),
    );
  }
}

class _PostsContent extends StatelessWidget {
  const _PostsContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: const PostsAppBar(),
      body: BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          if (state is PostsInitial || state is PostsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          if (state is PostsError) {
            return PostsErrorWidget(message: state.message);
          }

          final loaded = state as PostsLoaded;
          final posts = loaded.filteredPosts;

          if (loaded.allPosts.isEmpty) return const EmptyPosts();

          if (posts.isEmpty) return EmptySearch(query: loaded.searchQuery);

          return PostsList(posts: posts);
        },
      ),
    );
  }
}
