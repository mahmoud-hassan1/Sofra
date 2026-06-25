import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.height,
    this.width = double.infinity,
    this.bigBodrer =  2,
    this.smallBodrer = 2,
    required this.bgColor,
    this.topBorder = true,
    this.leftBorder = true,
    this.margin = false,
    required this.containerBody,
  });
  final double height;
  final double width;
  final double bigBodrer;
  final double smallBodrer;
  final Color bgColor;
  final bool topBorder;
  final bool leftBorder;
  final Widget containerBody;
  final bool margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin ? EdgeInsets.all(16) : null,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: BoxBorder.fromLTRB(
          left: leftBorder
              ? BorderSide(color: AppColors.neutralColor, width: smallBodrer)
              : BorderSide.none,
          top: topBorder
              ? BorderSide(color: AppColors.neutralColor, width: smallBodrer)
              : BorderSide.none,
          right: BorderSide(color: AppColors.neutralColor, width: bigBodrer),
          bottom: BorderSide(color: AppColors.neutralColor, width: bigBodrer),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutralColor,
            offset: Offset(8, 8),
            blurRadius: 0,
          ),
        ],
      ),
      child: containerBody,
    );
  }
}
