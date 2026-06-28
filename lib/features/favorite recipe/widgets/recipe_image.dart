import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';

class RecipeImage extends StatelessWidget {
  final String imageUrl;
  const RecipeImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(imageUrl, height: 230, width: 310, fit: BoxFit.cover),
        Positioned(
          top: 12,
          right: 15,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.neutralColor, width: 2.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.favorite, color: Colors.red),
          ),
        ),
      ],
    );
  }
}
