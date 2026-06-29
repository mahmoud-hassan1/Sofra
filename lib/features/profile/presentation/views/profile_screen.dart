import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/features/profile/data/models/profile_user_model.dart';
import 'package:sofra/features/profile/presentation/controllers/cubit/profile_cubit.dart';
import 'package:sofra/features/profile/presentation/views/widgets/profile_app_bar.dart';
import 'package:sofra/features/profile/presentation/views/widgets/profile_card.dart';
import 'package:sofra/features/profile/presentation/views/widgets/profile_error_widget.dart';
import 'package:sofra/features/profile/presentation/views/widgets/profile_favorites_row.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    // ProfileCubit is provided by HomeLayout so the BlocConsumer listener
    // there can call getProfile() every time the user switches to this tab.
    return const _ProfileContent();
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: const ProfileAppBar(),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.errorColor,
              ),
            );
          }
          if (state is ProfileUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile updated successfully!'),
                backgroundColor: Color(0xFF49654C),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading || state is ProfileInitial) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          if (state is ProfileError) {
            return ProfileErrorWidget(message: state.message);
          }

          final ProfileUserModel? user = switch (state) {
            ProfileLoaded(:final user) => user,
            ProfileUpdateSuccess(:final user) => user,
            _ => null,
          };

          if (user == null) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          return _ProfileBody(user: user);
        },
      ),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  final ProfileUserModel user;
  const _ProfileBody({required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileCard(user: user),
          const SizedBox(height: 32),
          Text('My Favorites', style: AppFonts.header.copyWith(fontSize: 22)),
          const SizedBox(height: 16),
          const ProfileFavoritesRow(),
        ],
      ),
    );
  }
}
