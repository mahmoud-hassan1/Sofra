import 'package:flutter/material.dart';
import 'package:sofra/core/utils/assets.dart';
import 'package:sofra/core/utils/colors.dart';

/// Circular avatar widget. Falls back to [Assets.profileDefaultImg] when
/// [avatarUrl] is null/empty or fails to load from network.
class ProfileAvatar extends StatelessWidget {
  final String? avatarUrl;
  final double size;
  final double borderWidth;
  final Offset shadowOffset;

  const ProfileAvatar({
    super.key,
    this.avatarUrl,
    this.size = 72,
    this.borderWidth = 2.5,
    this.shadowOffset = const Offset(3, 3),
  });

  @override
  Widget build(BuildContext context) {
    final hasUrl = avatarUrl != null && avatarUrl!.isNotEmpty;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.neutralColor, width: borderWidth),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutralColor,
            offset: shadowOffset,
            blurRadius: 0,
          ),
        ],
      ),
      child: ClipOval(
        child: hasUrl
            ? Image.network(
                avatarUrl!,
                width: size,
                height: size,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => _defaultImage(),
              )
            : _defaultImage(),
      ),
    );
  }

  Widget _defaultImage() => Image.asset(
        Assets.profileDefaultImg,
        width: size,
        height: size,
        fit: BoxFit.cover,
      );
}
