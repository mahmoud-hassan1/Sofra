import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/widgets/custom_card.dart';

class YoutubeContainer extends StatelessWidget {
  final String? youtubeUrl;
  
  const YoutubeContainer({
    super.key,
    this.youtubeUrl,
  });

  @override
  Widget build(BuildContext context) {
    if (youtubeUrl == null || youtubeUrl!.isEmpty) return const SizedBox.shrink();
    
    return CustomCard(
      height: 350,
      width: 354,
      bgColor: AppColors.primaryColor,
      containerBody: Center(
        child: CustomCard(
          height: 48,
          width: 84,
          padding: EdgeInsetsGeometry.all(0),
          smallBodrer: 3,
          bigBodrer: 3,
          shadow: 0,
          bgColor: AppColors.secondaryColor,
          containerBody: Center(
            child: Center(
              child: Icon(Icons.play_arrow_outlined, size: 30),
            ),
          ),
        ),
      ),
    );
  }
}
