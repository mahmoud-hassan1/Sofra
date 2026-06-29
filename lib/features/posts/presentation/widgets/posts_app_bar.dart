import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/features/posts/presentation/cubit/posts_cubit.dart';

class PostsAppBar extends StatefulWidget implements PreferredSizeWidget {
  const PostsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  State<PostsAppBar> createState() => _PostsAppBarState();
}

class _PostsAppBarState extends State<PostsAppBar> {
  bool _isSearching = false;
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _openSearch() => setState(() => _isSearching = true);

  void _closeSearch() {
    _controller.clear();
    context.read<PostsCubit>().clearSearch();
    setState(() => _isSearching = false);
  }

  void _onChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      if (mounted) context.read<PostsCubit>().search(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.brownAppBarBackground,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      titleSpacing: 20,
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(3),
        child: Divider(height: 3, thickness: 3, color: AppColors.neutralColor),
      ),
      title: _isSearching
          ? TextField(
              controller: _controller,
              onChanged: _onChanged,
              autofocus: true,
              style: AppFonts.bodyMedium.copyWith(
                color: AppColors.backGroundColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              cursorColor: AppColors.backGroundColor,
              decoration: InputDecoration(
                hintText: 'Search your posts...',
                hintStyle: AppFonts.bodyMedium.copyWith(
                  color: AppColors.backGroundColor.withValues(alpha: 0.6),
                  fontSize: 16,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            )
          : Text(
              'Sofra',
              style: AppFonts.header.copyWith(
                color: AppColors.backGroundColor,
                fontSize: 26,
              ),
            ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: IconButton(
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              size: 28,
              color: AppColors.backGroundColor,
            ),
            onPressed: _isSearching ? _closeSearch : _openSearch,
          ),
        ),
      ],
    );
  }
}
