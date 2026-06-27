import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/features/home/cubit/home_navigation_cubit.dart';
import 'package:sofra/features/auth/presentation/screens/login_screen.dart';
import 'package:sofra/features/home/home_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeNavigationCubit(),
      child: MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: AppColors.backGroundColor),
        debugShowCheckedModeBanner: false,
        home: const LoginScreen(),
      ),
    );
  }
}
