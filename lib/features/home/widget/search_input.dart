import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/features/home/cubit/home_body_cubit.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  late final TextEditingController _controller;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    final currentSearch = context.read<HomeBodyCubit>().state.searchQuery;
    _controller = TextEditingController(text: currentSearch);
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onChanged(String value) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.read<HomeBodyCubit>().changeSearchQuery(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBodyCubit, HomeBodyState>(
      listenWhen: (previous, current) => previous.searchQuery != current.searchQuery,
      listener: (context, state) {
        if (_controller.text != state.searchQuery) {
          _controller.text = state.searchQuery;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backGroundColor,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: AppColors.neutralColor, width: 1),
          boxShadow: const [
            BoxShadow(
              color: AppColors.neutralColor,
              offset: Offset(4, 6),
              blurRadius: 0,
            ),
          ],
        ),
        child: TextField(
          controller: _controller,
          onChanged: _onChanged,
          style: const TextStyle(
            color: AppColors.neutralColor,
            fontWeight: FontWeight.w500,
          ),
          decoration: const InputDecoration(
            hintText: 'Search for munchies...',
            hintStyle: TextStyle(
              color: AppColors.neutralColor,
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: Icon(Icons.search, color: AppColors.neutralColor, size: 26),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          ),
        ),
      ),
    );
  }
}