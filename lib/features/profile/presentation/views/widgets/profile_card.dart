import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/features/profile/data/models/profile_user_model.dart';
import 'package:sofra/features/profile/presentation/controllers/cubit/profile_cubit.dart';
import 'package:sofra/features/profile/presentation/views/edit_profile_dialog.dart';
import 'package:sofra/features/profile/presentation/views/widgets/profile_avatar.dart';

class ProfileCard extends StatelessWidget {
  final ProfileUserModel user;
  const ProfileCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final displayedName =
        (user.displayName != null && user.displayName!.isNotEmpty)
        ? user.displayName!
        : user.fullName;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutralColor, width: 2.5),
        boxShadow: const [
          BoxShadow(
            color: AppColors.neutralColor,
            offset: Offset(6, 6),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileAvatar(avatarUrl: user.avatarUrl, size: 72),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayedName,
                      style: AppFonts.header.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Email badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.neutralColor,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        user.email,
                        style: AppFonts.bodyMedium.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              // Edit button
              _EditButton(user: user),
            ],
          ),
          if (user.bio != null && user.bio!.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Divider(thickness: 1.5, color: Color(0xFFEEEEEE)),
            const SizedBox(height: 12),
            Text(
              user.bio!,
              style: AppFonts.bodyMedium.copyWith(
                fontSize: 14,
                color: AppColors.seconderyFontColor,
                height: 1.6,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Edit pencil button — opens the edit dialog
// ---------------------------------------------------------------------------
class _EditButton extends StatelessWidget {
  final ProfileUserModel user;
  const _EditButton({required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openEditDialog(context),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.neutralColor, width: 2),
          boxShadow: const [
            BoxShadow(
              color: AppColors.neutralColor,
              offset: Offset(3, 3),
              blurRadius: 0,
            ),
          ],
        ),
        child: const Center(
          child: Icon(Icons.edit_outlined, size: 18, color: Colors.black),
        ),
      ),
    );
  }

  void _openEditDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (_) => BlocProvider.value(
        value: context.read<ProfileCubit>(),
        child: EditProfileDialog(user: user),
      ),
    );
  }
}
