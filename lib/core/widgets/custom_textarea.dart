import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';

class CustomTextArea extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final int minLines;
  final int? maxLines;
  final ValueChanged<String>? onChanged;

  const CustomTextArea({
    super.key,
    this.controller,
    required this.hintText,
    this.minLines = 4,
    this.maxLines,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      onChanged: onChanged,
      keyboardType: TextInputType.multiline,
      style: const TextStyle(color: Colors.black, fontSize: 14),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppFonts.bodyMedium.copyWith(
          height: 1.0,
          color: AppColors.seconderyFontColor,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.neutralColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.neutralColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.secondaryColor,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorColor, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorColor, width: 1.5),
        ),
      ),
    );
  }
}
