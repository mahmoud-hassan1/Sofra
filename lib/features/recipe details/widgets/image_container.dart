import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/widgets/custom_card.dart';
import 'package:sofra/core/widgets/custom_tag_row.dart';

class ImageContiner extends StatelessWidget {
  final String imageUrl;
  final String region;
  final int likeCount;
  
  const ImageContiner({
    super.key,
    required this.imageUrl,
    required this.region,
    required this.likeCount,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      height: 350,
      width: 354,
      bgColor: AppColors.tertiaryColor,
      containerBody: Center(
        child: Stack(
          children: [
            Image.network(
              imageUrl,
              height: 344,
              width: 348,
              fit: BoxFit.fill,
            ),
            Positioned(
              top: 10,
              left: 15,
              child: CustomTagRow(
                label: region,
                color: Colors.white,
              ),
            ),
            Positioned(
              top: 10,
              right: 15,
              child: CustomTagRow(
                color: Colors.white,
                label: likeCount > 1000 ? "${(likeCount/1000).toStringAsFixed(1)}K" : likeCount.toString(),
                icon: Icon(Icons.favorite, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
