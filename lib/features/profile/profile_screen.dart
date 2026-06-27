import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';

/// Body widget for the Profile screen - contains only UI
class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tertiaryColor[500],
      body: SafeArea(
        child: Center(
          child: Text(
            "User Profile",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ),
    );
  }
}
