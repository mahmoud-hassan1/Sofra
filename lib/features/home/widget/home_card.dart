import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sofra/core/utils/assets.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/core/widgets/custom_card.dart';
import 'package:sofra/core/widgets/custom_tag_row.dart';
import 'package:sofra/core/widgets/neo_toggle_button.dart';

class HomeCard extends StatefulWidget {
  const HomeCard({
    super.key,
    required this.bgColor,
    required this.title,
    this.likesCount = 400,
    this.category = 'Fast Food',
    this.deliveryTime = '10m',
    this.tags = const ['italian', 'dinner'],
    this.imagePath = 'assets/images/img1.png',
  });

  final Color bgColor;
  final String title;
  final int likesCount;
  final String category;
  final String deliveryTime;
  final List<String> tags;
  final String imagePath;

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      height: 300,
      bgColor: widget.bgColor,
      containerBody: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                widget.imagePath,
                height: 125,
                fit: BoxFit.contain,
              ),
              Column(
                children: [
                  NeoToggleButton(
                    svgPath: Assets.favouriteIcon,
                    isActive: isFavorite,
                    activeBgColor: AppColors.backGroundSecondColor,
                    inactiveBgColor: AppColors.primaryColor[500]!,
                    activeIconColor: AppColors.primaryColor[500]!,
                    inactiveIconColor: AppColors.backGroundSecondColor,
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
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
            widget.title,
            style: AppFonts.label.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    Assets.thumbsUpIcon,
                    width: 32,
                    height: 32,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${widget.likesCount}',
                    style: AppFonts.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Text(
                widget.category,
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
                label: widget.deliveryTime,
                isActive: false,
                icon: SvgPicture.asset(
                  Assets.clockIcon,
                  width: 18,
                  height: 18,
                ),
              ),
              if (widget.tags.isNotEmpty)
                CustomTagRow(
                  label: widget.tags[0],
                  isActive: false,
                  icon: SvgPicture.asset(
                    Assets.dish01Icon,
                    width: 18,
                    height: 18,
                  ),
                ),
              if (widget.tags.length > 1)
                CustomTagRow(
                  label: widget.tags[1],
                  isActive: false,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
