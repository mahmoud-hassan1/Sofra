import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/features/profile/presentation/controllers/cubit/profile_cubit.dart';

class ProfileErrorWidget extends StatelessWidget {
  final String message;
  const ProfileErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off_rounded, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              message,
              style: AppFonts.bodyMedium.copyWith(
                fontSize: 16,
                color: AppColors.errorColor,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () => context.read<ProfileCubit>().getProfile(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black, width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(4, 4),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Text(
                  'TRY AGAIN',
                  style: AppFonts.label.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
