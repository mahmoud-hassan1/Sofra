import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sofra/core/utils/assets.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/core/widgets/custom_card.dart';
import 'package:sofra/core/widgets/custom_tag_row.dart';

class PopularItemCard extends StatelessWidget {
  const PopularItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      height: 240,
      bgColor: AppColors.secondaryColor[200]!,
      containerBody: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTagRow(
                    label: "Featured",
                    color: AppColors.tertiaryColor[200],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Beef Burger",
                    style: AppFonts.header.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF0088FF),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.neutralColor, width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.neutralColor,
                      offset: Offset(4, 4),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      Assets.thumbsUpIcon,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "300",
                      style: TextStyle(
                        color: AppColors.tertiaryColor[50],
                        fontFamily: AppFonts.robotoCondensed,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Spicy miso bliss that\nhits the\nspot.",
                        style: AppFonts.bodyMedium.copyWith(
                          color: AppColors.seconderyFontColor,
                          fontSize: 15,
                          height: 1.3,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor[500],
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: AppColors.neutralColor,
                              width: 2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.neutralColor,
                                offset: Offset(4, 4),
                                blurRadius: 0,
                              ),
                            ],
                          ),
                          child: Text(
                            "Grab it",
                            style: TextStyle(
                              color: AppColors.secondaryColor[500],
                              fontFamily: AppFonts.hankenGrotesk,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/images/img1.png',
                  height: 140,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
