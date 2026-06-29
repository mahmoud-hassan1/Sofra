import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';

class PostImage extends StatelessWidget {
  final String imageUrl;
  const PostImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) return _placeholder();
    return Image.network(
      imageUrl,
      width: 100,
      height: 110,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stack) => _placeholder(),
    );
  }

  Widget _placeholder() => Container(
    width: 100,
    height: 110,
    color: AppColors.primaryColor.shade50,
    child: const Icon(
      Icons.restaurant_rounded,
      size: 36,
      color: AppColors.primaryColor,
    ),
  );
}
