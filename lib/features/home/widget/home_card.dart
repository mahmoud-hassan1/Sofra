import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sofra/core/utils/assets.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/core/widgets/custom_card.dart';
import 'package:sofra/core/widgets/custom_tag_row.dart';
import 'package:sofra/core/widgets/neo_toggle_button.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.bgColor,
    required this.title,
    required this.isSaved,
    this.likesCount = 400,
    this.category = 'Fast Food',
    this.deliveryTime = '10m',
    this.tags = const ['italian', 'dinner'],
    this.imagePath = 'assets/images/img1.png',
    this.onFavoriteTap,
  });

  final Color bgColor;
  final String title;
  final bool isSaved;
  final int likesCount;
  final String category;
  final String deliveryTime;
  final List<String> tags;
  final String imagePath;
  final VoidCallback? onFavoriteTap;

  Widget _buildRecipeImage() {
    if (imagePath.isEmpty) {
      return Image.asset(
        'assets/images/ErrorImg.png',
        height: 125,
        fit: BoxFit.contain,
      );
    }

    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        height: 125,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Image.asset(
          'assets/images/ErrorImg.png',
          height: 125,
          fit: BoxFit.contain,
        ),
      );
    }

    return Image.asset(
      imagePath,
      height: 125,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => Image.asset(
        'assets/images/ErrorImg.png',
        height: 125,
        fit: BoxFit.contain,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      height: 300,
      bgColor: bgColor,
      containerBody: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRecipeImage(),
              Column(
                children: [
                  NeoToggleButton(
                    svgPath: Assets.favouriteIcon,
                    isActive: isSaved,
                    activeBgColor: AppColors.backGroundSecondColor,
                    inactiveBgColor: AppColors.primaryColor[500]!,
                    activeIconColor: AppColors.primaryColor[500]!,
                    inactiveIconColor: AppColors.backGroundSecondColor,
                    onTap: onFavoriteTap ?? () {},
                  ),
                  const SizedBox(height: 12),
                  NeoToggleButton(
                    svgPath: Assets.viewIcon,
                    isActive: false,
                    activeBgColor: AppColors.tertiaryColor[500]!,
                    inactiveBgColor: AppColors.tertiaryColor[500]!,
                    activeIconColor: AppColors.neutralColor,
                    inactiveIconColor: AppColors.neutralColor,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppFonts.label.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(Assets.thumbsUpIcon, width: 32, height: 32),
                  const SizedBox(width: 8),
                  Text(
                    '$likesCount',
                    style: AppFonts.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Text(
                category,
                style: AppFonts.header.copyWith(
                  fontSize: 24,
                  color: AppColors.primaryColor[500],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTagRow(
                label: deliveryTime,
                isActive: false,
                icon: SvgPicture.asset(Assets.clockIcon, width: 18, height: 18),
              ),
              if (tags.isNotEmpty)
                CustomTagRow(
                  label: tags[0],
                  isActive: false,
                  icon: SvgPicture.asset(
                    Assets.dish01Icon,
                    width: 18,
                    height: 18,
                  ),
                ),
              if (tags.length > 1)
                CustomTagRow(label: tags[1], isActive: false),
            ],
          ),
        ],
      ),
    );
  }
}
