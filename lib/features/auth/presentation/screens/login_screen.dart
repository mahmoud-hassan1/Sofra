import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sofra/core/utils/assets.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/core/widgets/custom_primary_button.dart';
import 'package:sofra/core/widgets/custom_text_form_field.dart';
import 'package:sofra/features/auth/presentation/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tertiaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              Center(
                child: Text(
                  'WELCOME BACK',
                  style: AppFonts.header.copyWith(
                    fontSize: 38,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                    color: AppColors.neutralColor,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 32,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.neutralColor, width: 2.5),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.neutralColor,
                      offset: Offset(8, 8),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CustomTextFormField(
                      label: 'Email',
                      hintText: 'foodie@munchiedash.com',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: AppColors.neutralColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const CustomTextFormField(
                      label: 'Password',
                      hintText: '........',
                      obscureText: true,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: AppColors.neutralColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Forgot Password?',
                          style: AppFonts.bodyMedium.copyWith(
                            color: AppColors.secondaryColor.shade800,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.secondaryColor.shade800,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomPrimaryButton(
                      text: 'LOGIN',
                      onPressed: () {},
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              color: AppColors.neutralColor,
                              thickness: 1.5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "OR",
                              style: AppFonts.label.copyWith(fontSize: 12),
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              color: AppColors.neutralColor,
                              thickness: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(
                          Assets.facebookIcon,
                          fillColor: const Color(0xFF1877F2),
                          iconColor: Colors.white,
                        ),
                        const SizedBox(width: 20),
                        _buildSocialButton(
                          Assets.google2,
                          fillColor: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'New here? ',
                    style: AppFonts.bodyMedium.copyWith(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'SIGN UP',
                      style: AppFonts.header.copyWith(
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                        decorationColor: AppColors.neutralColor,
                      ),
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

  Widget _buildSocialButton(
    String iconPath, {
    required Color fillColor,
    Color? iconColor,
  }) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: fillColor,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.neutralColor, width: 2),
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
          iconPath,
          width: 22,
          height: 22,
          colorFilter: iconColor != null
              ? ColorFilter.mode(iconColor, BlendMode.srcIn)
              : null,
        ),
      ),
    );
  }
}
