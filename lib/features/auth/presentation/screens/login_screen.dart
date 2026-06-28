import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sofra/core/utils/assets.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/core/widgets/custom_primary_button.dart';
import 'package:sofra/core/widgets/custom_text_form_field.dart';
import 'package:sofra/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sofra/features/auth/presentation/cubit/auth_state.dart';
import 'package:sofra/features/auth/presentation/screens/signup_screen.dart';
import 'package:sofra/features/home/home_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tertiaryColor,
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeLayout()),
              );
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.errorColor,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Form(
                key: _formKey,
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
                        border: Border.all(
                          color: AppColors.neutralColor,
                          width: 2.5,
                        ),
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
                          CustomTextFormField(
                            controller: _emailController,
                            label: 'Email',
                            hintText: 'foodie@munchiedash.com',
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: AppColors.neutralColor,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty)
                                return 'Email is required';
                              final emailRegex = RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              );
                              if (!emailRegex.hasMatch(value.trim()))
                                return 'Enter a valid email address';
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            controller: _passwordController,
                            label: 'Password',
                            hintText: '........',
                            obscureText: true,
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: AppColors.neutralColor,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Password is required';
                              return null;
                            },
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
                                  decorationColor:
                                      AppColors.secondaryColor.shade800,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          state is AuthLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                  ),
                                )
                              : CustomPrimaryButton(
                                  text: 'LOGIN',
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<AuthCubit>().login(
                                        email: _emailController.text.trim(),
                                        password: _passwordController.text,
                                      );
                                    }
                                  },
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Text(
                                    "OR",
                                    style: AppFonts.label.copyWith(
                                      fontSize: 12,
                                    ),
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
            );
          },
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
