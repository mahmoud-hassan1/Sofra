import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';

/// Body widget for the Posts screen - contains only UI
class PostsScreenBody extends StatelessWidget {
  const PostsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tertiaryColor[500],
      body: SafeArea(
        child: Center(
          child: Text(
            "My Posts",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ),
    );
  }
}
