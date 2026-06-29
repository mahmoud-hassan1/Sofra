import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/core/services/service_locator.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/features/add%20recipe/add_recipe.dart';
import 'package:sofra/features/home/cubit/home_navigation_cubit.dart';
import 'package:sofra/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sofra/features/auth/presentation/screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeNavigationCubit()),
        BlocProvider(create: (context) => sl<AuthCubit>()),
      ],
      child: MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: AppColors.backGroundColor),
        debugShowCheckedModeBanner: false,
        home: const LoginScreen(),
        // AddRecipeBody()
        // HomeScreenBody()
      ),
    );
  }
}