import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
// Make sure to import your AppColors path here!
// import 'package:your_app/theme/app_colors.dart';

class DecoratedContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double? height;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;

  const DecoratedContainer({
    super.key,
    required this.child,
    required this.width,
     this.height,      
    required this.backgroundColor,
    required this.padding 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.neutralColor, 
          width: 1.5,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.neutralColor,
            offset: Offset(4, 6),
            blurRadius: 0, 
          ),
        ],
      ),
      child: child,
    );
  }
}