import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sofra/core/utils/assets.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/core/widgets/custom_primary_button.dart';
import 'package:sofra/core/widgets/custom_text_form_field.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: AppColors.neutralColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.neutralColor,
                          offset: Offset(4, 4),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.arrowLeftIcon,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'JOIN US',
                    style: AppFonts.header.copyWith(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: AppColors.neutralColor,
                    ),
                  ),
                  SvgPicture.asset(Assets.noodleIcon, width: 70, height: 70),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  color: AppColors.backGroundSecondColor,
                  border: Border.all(color: AppColors.neutralColor, width: 2),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.neutralColor,
                      offset: Offset(6, 6),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.seconderyFontColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.neutralColor,
                          width: 2,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.neutralColor,
                            offset: Offset(3, 3),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.uploadImgIcon,
                          width: 28,
                          height: 28,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Upload Profile Image',
                      style: AppFonts.label.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Make it look tasty! (JPEG/PNG)',
                      style: AppFonts.bodyMedium.copyWith(
                        fontSize: 12,
                        color: AppColors.seconderyFontColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const CustomTextFormField(
                label: 'Full Name',
                hintText: 'Sammy Sandwiches',
              ),
              const SizedBox(height: 16),
              const CustomTextFormField(
                label: 'Email',
                hintText: 'sammy@munchies.com',
              ),
              const SizedBox(height: 16),
              const CustomTextFormField(
                label: 'Password',
                hintText: '........',
                obscureText: true,
              ),
              const SizedBox(height: 16),
              const CustomTextFormField(
                label: 'Confirm Password',
                hintText: '........',
                obscureText: true,
              ),
              const SizedBox(height: 32),
              CustomPrimaryButton(
                text: 'CREATE ACCOUNT →',
                onPressed: () {},
                color: AppColors.primaryColor,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: AppFonts.label.copyWith(fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Text(
                          'Login',
                          style: AppFonts.label.copyWith(
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            decorationThickness: 2,
                          ),
                        ),
                        Icon(Icons.login),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
