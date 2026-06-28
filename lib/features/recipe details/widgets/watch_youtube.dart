import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/core/widgets/custom_card.dart';

class WatchYoutube extends StatelessWidget {
  final String? youtubeUrl;
  
  const WatchYoutube({
    super.key,
    this.youtubeUrl,
  });

  @override
  Widget build(BuildContext context) {
    if (youtubeUrl == null || youtubeUrl!.isEmpty) return const SizedBox.shrink();

    return CustomCard(
      height: 58,
      width: 354,
      shadow: 3,
      bgColor: AppColors.primaryColor,
      containerBody: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: Colors.white,
            child: Center(
              child: Icon(
                Icons.play_arrow,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          SizedBox(width: 16),
          Text(
            "Watch on Youtube",
            style: AppFonts.bodyMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
